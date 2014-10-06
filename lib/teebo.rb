require 'sqlite3'
require 'yaml'
require 'randexp'

module Teebo

  class TeeboGenerator
    def initialize
      @db_connection = Teebo::DatabaseHandler.new
      @yaml_mapping = YAML::load(File.open('lib/data/en-us.yml'))
    end
  end
end

require 'teebo/database_handler'
require 'teebo/name'
require 'teebo/number'
require 'teebo/credit_card'