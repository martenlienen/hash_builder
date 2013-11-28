require "exec_env"

require "hash_builder/version"
require "hash_builder/template"

module HashBuilder
  # Build a Hash.
  #
  # args - Arguments to be passed to the hash
  # scope - Method calls in the block will be sent to scope object
  # locals - Local variables to be injected into the block
  #
  # Examples
  #
  #   HashBuilder.build(locals: {foo: 1}) do
  #     foo foo
  #     bar 2
  #   end
  #   # => { foo: 1, bar: 2}
  def self.build (args: [], scope: nil, locals: {}, &block)
    env = ExecEnv::Env.new
    env.scope = scope
    env.locals = locals
    
    block_result = env.exec(*args, &block)

    messages = env.messages

    if messages.size > 0
      hash = {}
      
      messages.each do |(name, args, block)|
        arg = args.first

        # ActiveRecord relations respond to :map but are no Enumerable
        if args.size == 1 && block && arg.respond_to?(:map) && !arg.is_a?(Hash)
          hash[name] = arg.map do |*objects|
            HashBuilder.build(args: objects, scope: scope, locals: locals, &block)
          end
        elsif block
          hash[name] = HashBuilder.build(scope: scope, locals: locals, &block)
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
