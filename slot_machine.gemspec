# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Engel"]
  gem.email         = ["paul.engel@holder.nl"]
  gem.summary       = %q{Lorem ipsum dolor sit amet, consectetur adipisicing eli}
  gem.description   = %q{Lorem ipsum dolor sit amet, consectetur adipisicing eli}
  gem.homepage      = "https://github.com/archan937/slot_machine"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "slot_machine"
  gem.require_paths = ["lib"]
  gem.version       = "0.1.0"
end