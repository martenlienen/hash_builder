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
(HashBuilder.build_with_env(scope: self, locals: local_assigns) do
  #{template.source}
end)
RUBY
      if !is_partial?(template)
        render_code += ".to_json"
      end
      
      render_code
    end

    def self.is_partial? (template)
      template.virtual_path.split("/").last.start_with?("_")
    end
  end
end

if defined?(Rails)
  ActionView::Template.register_template_handler :json_builder, HashBuilder::Template
end
