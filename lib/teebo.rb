require 'yaml'

class Teebo

  def initialize
    # Load YAML for hardcoded data
    @en = YAML::load_file(File.join(__dir__, 'locales', 'en.yml'))
  end

  def sum_count
    sum = 0
    for element in @en.names.given
      sum += element.count
    end
    puts sum
  end

end
