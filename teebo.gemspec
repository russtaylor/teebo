lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'teebo'
  s.version     = '0.0.4'
  s.date        = '2014-09-12'
  s.summary     = 'Teebo gem.'
  s.description = 'Contains basic functionality for data generation.'
  s.authors     = ['Russ Taylor']
  s.email       = 'russ@russt.me'
  s.require_paths = ['lib']
  s.files       = %w(
    lib/teebo.rb
    lib/teebo/name.rb
    lib/teebo/number.rb
    lib/teebo/credit_card.rb
    lib/teebo/database_handler.rb
    lib/data/en-us.yml
    lib/data/seed-data.db
  )
  s.homepage    = 'http://github.com/russtaylor/teebo'
  s.license     = 'MIT'

  s.add_runtime_dependency 'sqlite3', '~>1.3', '>= 1.3.9'
end
