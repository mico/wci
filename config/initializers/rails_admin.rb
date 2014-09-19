require "rails_admin_import/engine"
require "rails_admin_import/import"
require "rails_admin_import/config"

module RailsAdminImport
  def self.config(entity = nil, &block)
    if entity
      RailsAdminImport::Config.model(entity, &block)
    elsif block_given? && ENV['SKIP_RAILS_ADMIN_INITIALIZER'] != "true"
      block.call(RailsAdminImport::Config)
    else
      RailsAdminImport::Config
    end
  end

  def self.reset
    RailsAdminImport::Config.reset
  end
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Import < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option(:collection) do
          true
        end

        register_instance_option(:http_methods) do
          [:get, :post]
        end

        register_instance_option(:link_icon) do
          'icon-folder-open'
        end

        register_instance_option :controller do
          Proc.new do
            # make sure class has import-related methods
            @abstract_model.model.send :include, ::RailsAdminImport::Import

            @file_formats_accepted = @abstract_model.model.file_formats_accepted

            @response = {}


            # debugger

            if request.post?
              # if !params.has_key?(:input)
              #   return results = { :success => [], :error => ["You must select a file."] }
              # end

              if params.has_key?(:do_import)

                params[:event_location_id].each do |uid, event_type|
                  if params[:bulk_ids].include?(uid)

                  end
                  ImportedEvent.create(ical_uid: uid)
                end


                redirect_to index_path(model_name: :event)
                # redirect to list filtered
              end

              associated_map = {}
              # @abstract_model.model.belongs_to_fields.flatten.each do |field|
              #   associated_map[field] = field.to_s.classify.constantize.all.inject({}) { |hash, c| hash[c.send(params[field]).to_s] = c.id; hash }
              # end
              # @abstract_model.model.many_fields.flatten.each do |field|
              #   associated_map[field] = field.to_s.classify.constantize.all.inject({}) { |hash, c| hash[c.send(params[field]).to_s] = c; hash }
              # end

              if params[:url]
                results = @abstract_model.model.rails_admin_import({
                     input: params[:url],
                     type: :url,
                     format: params[:input_format].to_sym,
                     lookup: params[:update_lookup],
                     associated_map: associated_map,
                     role: nil,
                     user: _current_user
                 })
              else
                results = {:success => [], :error => ["Failed"]}
              end

              @response[:notice] = results[:success].join("<br />").html_safe if results[:success].any?
              @response[:error] = results[:error].join("<br />").html_safe if results[:error].any?
              @response[:confirmation] = results[:confirmation]
            end

            render :action => @action.template_name
          end
        end
      end
    end
  end
end


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    import


    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

RailsAdminImport.config do |config|
  config.model Event do

    # Fields to make available for import (whitelist)
    #included_fields do
    #  [:field1, :field2, :field3]
    # end

    # Fields to skip (blacklist)
    # excluded_fields do
    #  [:field1, :field2, :field3]
    # end

    # Custom methods to get/set the values on? (Not in use?)
    # extra_fields do
    #  [:field3, :field4, :field5]
    # end

    # Name of the method on the model to use in alert messages indicating success/failure of import
    label :title

    # Specifies the field to use to find existing records (when nil, admin page shows dropdown with options)
    #update_lookup_field do
    #  :id
    #end

    # map fields to an RSS feed
    ical_mapping do
      {
          :title => Proc.new{ |item| item.summary.is_a?(Icalendar::Values::Array) ? item.summary.join(" ") : item.summary },
          :date => Proc.new{ |item| item.dtstart },
          :ical_uid => Proc.new{ |item| item.uid.to_s },
          :url => Proc.new{ |item| item.url.to_s },
          :description => Proc.new{ |item| item.description.to_s },
          :to_import => Proc.new { |item| true },
          :to_import_location => Proc.new{ |item| item.location.to_s },
      }
    end

    # Define instance methods to be hooked into the import process, if special/additional processing is required on the data
    before_import_save do
      # block must return an object that responds to the "call" method
      lambda do |model, row, map|
        # skip confirmation email when importing Devise User model
        model.skip_confirmation!
      end
    end
  end
end
