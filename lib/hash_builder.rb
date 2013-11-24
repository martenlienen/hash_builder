require "exec_env"

require "hash_builder/version"
require "hash_builder/template"

module HashBuilder
  def self.build (*args, &block)
    build_with_args(*args, &block)
  end

  def self.build_with_args (*args, &block)
    env = ExecEnv::Env.new
    env.exec(*args, &block)

    hash = {}

    env.captured_messages.each do |(name, (arg), block)|
      if arg && block && arg.is_a?(Enumerable) && !arg.is_a?(Hash)
        hash[name] = arg.map do |*args|
          HashBuilder.build(*args, &block)
        end
      elsif block
        hash[name] = HashBuilder.build(&block)
      else
        hash[name] = arg
      end
    end

    hash
  end
end
