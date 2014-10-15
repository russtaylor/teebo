require 'sqlite3'
require 'yaml'
require 'randexp'

module Teebo

  class TeeboGenerator
    def self.db_connection
      @db_connection ||= Teebo::DatabaseHandler.new
    end

    def self.yaml_mapping
      @yaml_mapping ||= YAML::load(File.open('lib/data/en-us.yml'))
    end
  end
end

require 'teebo/database_handler'
require 'teebo/name'
require 'teebo/number'
require 'teebo/credit_card'