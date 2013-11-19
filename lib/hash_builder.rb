require "hash_builder/version"
require "hash_builder/execution_environment"

module HashBuilder
  def self.build (&block)
    environment = HashBuilder::ExecutionEnvironment.new
    environment.execute(&block)

    hash = {}

    environment.captured_calls.each do |(name, (arg), block)|
      hash[name] = arg
    end

    hash
  end
end
