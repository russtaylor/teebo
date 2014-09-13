Gem::Specification.new do |s|
  s.name        = 'teebo'
  s.version     = '0.0.1'
  s.date        = '2014-09-12'
  s.summary     = "Teebo gem."
  s.description = "Contains basic functionality for data generation."
  s.authors     = ["Russ Taylor"]
  s.email       = 'russ@russt.me'
  s.files       = ['lib/teebo.rb', 'lib/data/seed-data.db', 'lib/teebo/name.rb']
  s.homepage    = 'http://rubygems.org/gems/teebo'
  s.license     = 'MIT'

  s.add_runtime_dependency "sqlite3", "~>1.3", ">= 1.3.9"
end
