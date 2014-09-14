require 'sqlite3'

module Teebo

  class Base

    def initialize
      # Initialize the database
      @@database = SQLite3::Database.new "lib/data/seed-data.db"
      @@database.results_as_hash = true
    end

  end
end

require 'teebo/name'
