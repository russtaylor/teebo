require 'sqlite3'

module Teebo

  class Base
    @db_connection = Teebo::Database.new
  end
end

require 'teebo/database'
require 'teebo/name'
