describe HashBuilder::ExecutionEnvironment do
  let(:environment) { HashBuilder::ExecutionEnvironment.new }
  
  it "should capture method calls with args and block" do
    block = -> { 13 }
    
    environment.execute do
      just_a_name

      with_param 6077

      with_block &block
    end

    expect(environment.captured_calls).to eq [
      [:just_a_name, [], nil],
      [:with_param, [6077], nil],
      [:with_block, [], block]
    ]
  end

  it "should allow capturing calls with existing names" do
    block = -> { 13 }
    
    environment.execute do
      send :with_send, 13
    end

    expect(environment.captured_calls).to eq [[:with_send, [13], nil]]
  end
end
