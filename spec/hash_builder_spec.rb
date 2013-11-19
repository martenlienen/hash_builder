describe HashBuilder do
  it "should construct a simple hash" do
    hash = HashBuilder.build do
      key "A test key"

      number 1337
    end

    expect(hash).to eq({ key: "A test key", number: 1337 })
  end
end
