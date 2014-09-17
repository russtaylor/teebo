lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'teebo'
  s.version     = '0.0.3'
  s.date        = '2014-09-12'
  s.summary     = "Teebo gem."
  s.description = "Contains basic functionality for data generation."
  s.authors     = ["Russ Taylor"]
  s.email       = 'russ@russt.me'
  s.require_paths = ["lib"]
  s.files       = [
    "lib/teebo.rb",
    "lib/data/seed-data.db",
    "lib/teebo/name.rb"
  ]
  s.homepage    = 'http://github.com/russtaylor/teebo'
  s.license     = 'MIT'

  s.add_runtime_dependency "sqlite3", "~>1.3", ">= 1.3.9"
end
