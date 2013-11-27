module HashBuilder
  # Renders templates with '.json_builder' extension.
  #
  # If the template is a normal view, it will render a JSON string.
  # If the template however is a partial, it renders a Hash so that
  # json_builder files can use partials.
  class Template
    def self.default_format
      Mime::JSON
    end

    def self.call (template)
      render_code = <<-RUBY
HashBuilder.build_with_env(scope: self, locals: local_assigns) do
  #{template.source}
end
RUBY
      if !is_partial?(template)
        # ActiveModel defines #as_json in a way, that is not compatible
        # with JSON.
        if defined?(ActiveModel)
          render_code = "ActiveSupport::JSON.encode(#{render_code})"
        else
          render_code = "JSON.generate(#{render_code})"
        end
      end
      
      render_code
    end

    def self.is_partial? (template)
      template.virtual_path.split("/").last.start_with?("_")
    end
  end
end

if defined?(ActionView)
  ActionView::Template.register_template_handler :json_builder, HashBuilder::Template
end
