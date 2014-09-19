require 'sqlite3'

module Teebo

  class TeeboGenerator
    attr_accessor :db_connection

    def initialize
      @db_connection = Teebo::GeneratorDatabase.new
    end
  end
end

require 'teebo/generator_database'
require 'teebo/name'
