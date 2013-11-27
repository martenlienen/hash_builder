require "benchmark"
require "json"
require "hash_builder"
require "json_builder"

template = (-> {
              name "Garrett Bjerkhoel"
              birthday Time.local(1991, 9, 14)
              
              street do
                address "1143 1st Ave"
                address2 "Apt 200"
                city "New York"
                state "New York"
                zip 10065
              end
              
              skills do
                ruby true
                asp false
                php true
                mysql true
                mongodb true
                haproxy true
                marathon false
              end
              
              single_skills ['ruby', 'php', 'mysql', 'mongodb', 'haproxy']
              booleans [true, true, false, nil]             
            })

runs = 15000
Benchmark.bm(28) do |bench|
  bench.report("HashBuilder") do
    runs.times do
      HashBuilder.build(&template)
    end
  end

  bench.report("HashBuilder + JSON.generate") do
    runs.times do
      JSON.generate(HashBuilder.build(&template))
    end
  end
  
  bench.report("HashBuilder + to_json") do
    runs.times do
      HashBuilder.build(&template).to_json
    end
  end

  bench.report("JSONBuilder") do
    runs.times do
      JSONBuilder::Compiler.generate(&template)  
    end
  end
end
