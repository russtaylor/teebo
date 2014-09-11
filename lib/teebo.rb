require 'yaml'

class Teebo

  def initialize
    # Load YAML for hardcoded data
    @en = YAML::load_file(File.join(__dir__, 'locales', 'en.yml'))
  end

  def sum_count
    sum = 0
    @en['names']['given'].each do |element|
      sum += element['count']
    end
    puts sum
  end

end
