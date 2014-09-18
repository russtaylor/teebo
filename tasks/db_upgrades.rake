require 'sqlite3'

$database = SQLite3::Database.new '../lib/data/seed-data.db'
$database.results_as_hash = true

def update_given_name_sum_count
  sexes = %w(M F)
  sexes.each do |sex|
    get_rows = <<-SQL
      select * from given_names where sex = ?
    SQL

    put_count_to = <<-SQL
      update given_names set count_to = ? where id = ?
    SQL

    count = 0
    $database.execute(get_rows, sex) do |row|
      count += row['count']
      $database.execute(put_count_to, count, row[0])
    end
  end
end

def update_surname_sum_count
  get_rows = <<-SQL
    select * from surnames
  SQL

  put_count_to = <<-SQL
    update surnames set count_to = ? where id = ?
  SQL

  count = 0
  $database.execute(get_rows) do |row|
    count += row['count']
    $database.execute(put_count_to, count, row[0])
  end
end

def update_capitalization(column_name)
  select_statement = <<-SQL
    select * from surnames
  SQL

  update_statement = <<-SQL
    update surnames set name = ? where id = ?
  SQL

  $database.execute(select_statement) do |row|
    text = row[column_name].capitalize
    $database.execute(update_statement, text, row['id'])
  end
end

update_capitalization('name')
