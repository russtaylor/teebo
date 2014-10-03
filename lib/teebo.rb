require 'sqlite3'
require 'yaml'

module Teebo

  class TeeboGenerator
    def initialize
      @db_connection = Teebo::DatabaseHandler.new
      @yaml_mapping = YAML::load(File.open('lib/data/en-us.yml'))
    end
  end

  def self.iterate(h)
    h.each do |k,v|
      value = v || k

      if value.is_a?(Hash) || value.is_a?(Array)
        iterate(value)
      else
        if value.instance_of?(Range)
          return value.to_a
        end
      end
    end
  end

  def expand_yaml_range(yaml)

  end
end

require 'teebo/database_handler'
require 'teebo/name'
require 'teebo/number'
require 'teebo/credit_card'