if defined?(Rails)
  class ActionView::Template::Handlers
    self.default_format = Mime::JSON

    def self.call (template)
      "ActionView::Template::Handlers::JsonBuilder.new(self).render(-> { #{template.source} }, local_assigns)"
    end

    def initialize (view)
      @view = view
    end

    def render (template, local_assigns = {})
      HashBuilder.build(&template).to_json
    end

    ActionView::Template.register_template_handler :json_builder, HashBuilder::Template
  end
end
