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
end
