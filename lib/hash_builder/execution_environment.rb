module HashBuilder
  # An empty environment, that captures all method calls, that are executed in
  # the context of it's instance.
  class ExecutionEnvironment
    def initialize
      @calls = []
    end
    
    def execute (&block)
      instance_exec(&block)
    end

    def method_missing (name, *args, &block)
      @calls << [name, args, block]
    end

    def captured_calls
      @calls
    end
  end
end
