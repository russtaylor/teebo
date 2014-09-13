# require 'sqlite3'
#
# database = SQLite3::Database.new "lib/data/seed-data.db"
#
# get_rows = <<-SQL
#   select * from given_names where sex = ?
# SQL
#
# put_count_to = <<-SQL
#   update given_names set count_to = ? where id = ?
# SQL
#
# count = 0
# database.execute(get_rows, 'F') do |row|
#   count += row[3]
#   database.execute(put_count_to, count, row[0])
# end

require 'sqlite3'

database = SQLite3::Database.new "lib/data/seed-data.db"

find_count = <<-SQL
  select sum(count) from given_names where sex = 'M'
SQL

find_closest_query = <<-SQL
  select * from given_names where sex = 'M' and (count_to - ?) >= 0 order by id limit 1
SQL

count = database.execute(find_count)[0][0]

rand = rand(count)

puts database.execute(find_closest_query, rand).inspect
