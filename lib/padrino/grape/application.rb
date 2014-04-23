module Padrino
  module Grape
    module Application
      def self.included(base)
        base.extend(ClassMethods)

        base_file_path = caller[0].split(':')[0]
        base.define_singleton_method(:app_file) do
          base_file_path
        end
      end

      module ClassMethods
        def api_root
          @api_root ||= File.expand_path(File.dirname(app_file))
        end

        # required
        def app_name
          self.to_s.underscore.to_sym
        end

        # required
        def public_folder
          ""
        end

        # required
        def setup_application!
          return if @_configured
          require_dependencies
          @_configured = true
        end

        def load_paths
          @_load_paths ||= [].map { |path| File.join(api_root, path) }
        end

        def dependencies
          [].map { |file| Dir[File.join(api_root, file)] }.flatten
        end

        protected
        def require_dependencies
          Padrino.set_load_paths(*load_paths)
          Padrino.require_dependencies(dependencies, :force => true)
        end
      end
    end
  end
end
