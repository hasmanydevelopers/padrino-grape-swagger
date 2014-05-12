module Padrino
  module Grape
    module SwaggerUI
      def self.find_swagger_ui_asset(dir, file)
        [Padrino.root("public/swagger-ui"),
        File.expand_path("../../../../vendor/swagger-ui", __FILE__)].each do |root|
          asset_path = File.join(*[root, dir, file].compact)
          return asset_path if File.exists?(asset_path)
        end
        nil
      end

      module Helpers
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def mount_swagger_docs(swagger_doc_path, api_doc_ns = nil)

            self.controller api_doc_ns do
              before :root, :assets do
                asset = Padrino::Grape::SwaggerUI.find_swagger_ui_asset(params[:asset_dir], params[:asset_file])
                if asset 
                  content_type File.extname(asset).gsub(/^./, "").to_sym
                  send_file asset
                else
                  halt 404
                end
              end

              get "swagger_url.js" do
                content_type :js
                "window.SWAGGER_URL = '#{request.scheme}://#{request.host}:#{request.port}/#{swagger_doc_path}';"
              end

              get :index do
                if api_doc_ns.nil?
                 redirect_to url_for(:root, asset_file: "index.html")
                else 
                  redirect_to url_for(api_doc_ns.to_sym, :root, asset_file: "index.html")
                end
              end

              get :root, map: "#{api_doc_ns}/:asset_file" do; end;

              get :assets, map: "#{api_doc_ns}/:asset_dir/:asset_file" do; end;
            end
          end
        end
      end

      class << self
        def registered(app)
          app.helpers Padrino::Grape::SwaggerUI::Helpers
        end
      end
    end
  end
end