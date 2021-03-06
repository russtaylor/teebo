lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'teebo'
  s.version     = '0.0.6'
  s.date        = '2014-10-15'
  s.summary     = 'Teebo gem.'
  s.description = 'Contains basic functionality for data generation.'
  s.authors     = ['Russ Taylor']
  s.email       = 'russ@russt.me'
  s.require_paths = ['lib']
  s.files       = ['lib/teebo.rb']
  s.files       += Dir['lib/teebo/*']
  s.files       += Dir['lib/data/*']
  s.homepage    = 'http://github.com/russtaylor/teebo'
  s.license     = 'MIT'

  s.add_runtime_dependency 'sqlite3', '~>1.3', '>= 1.3.9'
  s.add_runtime_dependency 'randexp', '~>0.1.7'
end
