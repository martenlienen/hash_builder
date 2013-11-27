require "json"

class ViewStub
  def local_assigns
    {}
  end
end

describe HashBuilder::Template do
  let(:view) { ViewStub.new }

  it "should render a template into a JSON string" do
    template = double("template", source: "foo 1\nbar 'test'", virtual_path: "test/index")

    code = HashBuilder::Template.call(template)
    json = view.instance_eval(code)

    expect(JSON.parse(json)).to eq({ "foo" => 1, "bar" => "test" })
  end

  it "should render a hash if the template is a partial" do
    template = double("template", source: "foo 1\nbar 'test'", virtual_path: "test/_index")

    code = HashBuilder::Template.call(template)
    hash = view.instance_eval(code)

    expect(hash).to eq({ foo: 1, bar: "test" })
  end
end
