def update_given_name_sum_count
  sexes = ['M', 'F']
  sexes.each do |sex|
    get_rows = <<-SQL
      select * from given_names where sex = ?
    SQL

    put_count_to = <<-SQL
      update given_names set count_to = ? where id = ?
    SQL

    count = 0
    @@database.execute(get_rows, sex) do |row|
      count += row['count']
      @@database.execute(put_count_to, count, row[0])
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
  @@database.execute(get_rows) do |row|
    count += row['count']
    @@database.execute(put_count_to, count, row[0])
  end
end
