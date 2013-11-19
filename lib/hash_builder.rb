require "hash_builder/version"
require "hash_builder/execution_environment"

module HashBuilder
  def self.build (&block)
    build_with_args(&block)
  end

  # Wraps a block with HashBuilder.build while passing args through, to the
  # original block.
  def self.block (&block)
    lambda do |*args|
      HashBuilder.build_with_args(*args, &block)
    end
  end

  def self.build_with_args (*args, &block)
    environment = HashBuilder::ExecutionEnvironment.new
    environment.execute(*args, &block)

    hash = {}

    environment.captured_calls.each do |(name, (arg), block)|
      if arg && block && arg.is_a?(Enumerable) && !arg.is_a?(Hash)
        hash[name] = arg.map &(HashBuilder.block &block)
      elsif block
        hash[name] = HashBuilder.build(&block)
      else
        hash[name] = arg
      end
    end

    hash
  end
end
