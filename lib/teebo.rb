require 'sqlite3'

module Teebo

  class TeeboGenerator
    def initialize
      @db_connection = Teebo::DatabaseHandler.new
    end
  end
end

require 'teebo/database_handler'
require 'teebo/name'
