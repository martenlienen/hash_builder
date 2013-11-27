describe HashBuilder do
  it "should construct a simple hash" do
    hash = HashBuilder.build do
      key "A test key"

      number 1337
    end

    expect(hash).to eq({ key: "A test key", number: 1337 })
  end

  it "should construct nested hashes" do
    hash = HashBuilder.build do
      level1 "Easy"

      container do
        level2 "Harder"
      end
    end

    expect(hash).to eq({ level1: "Easy", container: { level2: "Harder" } })
  end

  it "should iterate over enumerables if arg and block is given" do
    hash = HashBuilder.build do
      numbers (0..3).to_a do |num|
        i num
      end
    end

    expect(hash).to eq({ numbers: [{ i: 0 }, { i: 1 }, { i: 2 }, { i: 3 }] })
  end

  it "should pass the environment into nested blocks" do
    scope = Object.new
    scope.instance_variable_set(:@id, 13)

    hash = HashBuilder.build_with_env(locals: { user: "CQQL" }, scope: scope) do
      user do
        name user
        id @id
      end
    end

    expect(hash).to eq({ user: { id: 13, name: "CQQL" } })
  end

  it "should not set keys that have no explicit value" do
    hash = HashBuilder.build do
      read
      write 1
    end

    expect(hash).to eq({ write: 1 })
  end

  it "should allow setting keys to nil" do
    hash = HashBuilder.build do
      foo nil
    end

    expect(hash).to eq({ foo: nil })
  end
end
