if defined?(Rails)
  class ActionView::Template::Handlers::JsonBuilder
    class_attribute :default_format
    self.default_format = Mime::JSON

    def self.call (template)
      <<-RUBY
(HashBuilder.build_with_env(scope: self, locals: local_assigns) do
  #{template.source}
end).to_json
RUBY
    end

    ActionView::Template.register_template_handler :json_builder, ActionView::Template::Handlers::JsonBuilder
  end
end
