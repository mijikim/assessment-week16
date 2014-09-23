require 'awesome_print'
require 'csv'

class Metrics
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def parse
    CSV.read(@filepath, {:col_sep => "\t"})
  end

  def create_hash_with_keys(array_of_arrays)
    nested_hash = Hash.new do |hash, key|
      hash[key] = {}
    end

    array_of_arrays.each { |row|
      nested_hash.compare_by_identity
      main_key = row[1]
      nested_hash[main_key]["time"] = row[0]
      nested_hash[main_key]["name"] = row[1]
      nested_hash[main_key]["pH"] = row[2]
      nested_hash[main_key]["nutrient_solution_level"] = row[3]
      nested_hash[main_key]["temperature"] = row[4]
      nested_hash[main_key]["water_level"] = row[5]
    }

    nested_hash.group_by { |row| row[0] }.each { |key, values| values.map! { |key, value| values.delete(key) & value.delete(value[1]); value } }
  end

  def return_hash_with_avgs(hash)
    nested_hash = Hash.new do |h, key|
      h[key] = {}
    end

    pH = 0
    nutrient_solution_level = 0
    temp = 0
    h2o_level = 0
    count = 0
    hash["container1"].each { |array|
    count += 1
    nested_hash["container1"]["pH"] = ((pH += array["pH"].to_f)/count).round(2)
    nested_hash["container1"]["nutrient_solution_level"] = ((nutrient_solution_level += array["nutrient_solution_level"].to_f)/count).round(2)
    nested_hash["container1"]["temperature"] = ((temp += array["temperature"].to_f)/count).round(2)
    nested_hash["container1"]["water_level"] = ((h2o_level += array["water_level"].to_f)/count).round(2)
    }

    pH = 0
    nutrient_solution_level = 0
    temp = 0
    h2o_level = 0
    count = 0
    hash["container2"].each { |array|
      count += 1
      nested_hash["container2"]["pH"] = ((pH += array["pH"].to_f)/count).round(2)
      nested_hash["container2"]["nutrient_solution_level"] = ((nutrient_solution_level += array["nutrient_solution_level"].to_f)/count).round(2)
      nested_hash["container2"]["temperature"] = ((temp += array["temperature"].to_f)/count).round(2)
      nested_hash["container2"]["water_level"] = ((h2o_level += array["water_level"].to_f)/count).round(2)
    }

    pH = 0
    nutrient_solution_level = 0
    temp = 0
    h2o_level = 0
    count = 0
    hash["container3"].each { |array|
      count += 1
      nested_hash["container3"]["pH"] = ((pH += array["pH"].to_f)/count).round(2)
      nested_hash["container3"]["nutrient_solution_level"] = ((nutrient_solution_level += array["nutrient_solution_level"].to_f)/count).round(2)
      nested_hash["container3"]["temperature"] = ((temp += array["temperature"].to_f)/count).round(2)
      nested_hash["container3"]["water_level"] = ((h2o_level += array["water_level"].to_f)/count).round(2)
    }
    ap nested_hash
  end


end

metrics = Metrics.new('/Users/MiJi/gSchoolWork/assessments/g3-assessment-week-16/data/metrics.tsv')
metrics.return_hash_with_avgs(metrics.create_hash_with_keys(metrics.parse))
