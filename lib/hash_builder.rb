require "exec_env"

require "hash_builder/version"
require "hash_builder/template"

module HashBuilder
  def self.build (*args, &block)
    build_with_env(args: args, &block)
  end
  
  def self.build_with_env (args: [], scope: nil, bindings: {}, &block)
    env = ExecEnv::Env.new
    env.scope = scope
    env.bindings = bindings
    
    block_result = env.exec(*args, &block)

    messages = env.free_messages

    if messages.size > 0
      hash = {}
      
      messages.each do |(name, (arg), block)|
        if arg && block && arg.is_a?(Enumerable) && !arg.is_a?(Hash)
          hash[name] = arg.map do |*objects|
            HashBuilder.build_with_env(args: objects, scope: scope, bindings: bindings, &block)
          end
        elsif block
          hash[name] = HashBuilder.build_with_env(scope: scope, bindings: bindings, &block)
        elsif arg
          hash[name] = arg
        end
      end

      hash
    else
      block_result
    end
  end
end
