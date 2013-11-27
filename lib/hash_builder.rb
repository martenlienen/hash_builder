require "exec_env"

require "hash_builder/version"
require "hash_builder/template"

module HashBuilder
  # A shorthand method for everyday hash building.
  def self.build (*args, &block)
    build_with_env(args: args, &block)
  end

  # Build a Hash.
  #
  # args - Arguments to be passed to the hash
  # scope - Method calls in the block will be sent to scope object
  # locals - Local variables to be injected into the block
  #
  # Examples
  #
  #   HashBuilder.build_with_env(locals: {foo: 1}) do
  #     foo foo
  #     bar 2
  #   end
  #   # => { foo: 1, bar: 2}
  def self.build_with_env (args: [], scope: nil, locals: {}, &block)
    env = ExecEnv::Env.new
    env.scope = scope
    env.locals = locals
    
    block_result = env.exec(*args, &block)

    messages = env.messages

    if messages.size > 0
      hash = {}
      
      messages.each do |(name, args, block)|
        arg = args.first
        
        if args.size == 1 && block && arg.is_a?(Enumerable) && !arg.is_a?(Hash)
          hash[name] = arg.map do |*objects|
            HashBuilder.build_with_env(args: objects, scope: scope, locals: locals, &block)
          end
        elsif block
          hash[name] = HashBuilder.build_with_env(scope: scope, locals: locals, &block)
        elsif args.size == 1
          hash[name] = arg
        end
      end

      hash
    else
      block_result
    end
  end
end
