require 'awesome_print'
require 'csv'

class Metrics
  attr_reader :filepath

  def initialize(filepath)
  @filepath = filepath
  end

  def parse
    CSV.read(@filepath, { :col_sep => "\t" })
  end

  def create_hash_with_keys(array_of_arrays)
    hash = {}
    array_of_arrays.each { |row|
      hash.compare_by_identity

      hash[:time] = row[0]
      hash[:name] = row[1]
      hash[:pH] = row[2]

      # hash[row[1]] = row
    }

    ap hash
    # new_hash = (hash.group_by {|row| row[0]}).each { |key, values| values.map! {|key, value| values.delete(key) & value.delete(value[1]); value }}
    #
    # hash = {}
    # hash_with_keys = new_hash.each {|key, values| values.map! {|item|
    #   hash.compare_by_identity
    # hash[:time] = item[0]
    # hash[:pH] = item[1]
    # hash[:nutrient_solution_level] = item[2]
    # hash[:temperature] = item[3]
    # hash[:water_level] = item[4] ; hash}}

  end

  # def return_hash_with_avgs(hash)
  #   pH = 0.00
  #   nutrient_solution_level = 0.00
  #   temp = 0.00
  #   h2o_level = 0.00
  #   count = 0.00
  #   new_hash = {}
  #   hash["container1"].map! { |values|
  #   pH += values[:pH].to_f
  #   nutrient_solution_level += values[:nutrient_solution_level].to_f
  #   temp += values[:temperature].to_f
  #   h2o_level += values[:water_level].to_f
  #   count += 1 }
  #   Hash.new["container1"] =
  #   (new_hash[:temp]= pH/count
  #   new_hash[:nutrient_solution_level] = nutrient_solution_level/count
  #   new_hash[:temperature] = temp/count
  #   new_hash[:water_level] = h2o_level/count)
  # new_hash
  # end




end

metrics = Metrics.new('/Users/MiJi/gSchoolWork/assessments/g3-assessment-week-16/data/metrics.tsv')
# metrics.return_hash_with_avgs(metrics.create_hash_with_keys(metrics.parse))
metrics.create_hash_with_keys(metrics.parse)

  # def parse
  #   open(@filepath) do |f|
  #     headers = f.gets.strip.split("\t")
  #     f.each do |line|
  #       fields = Hash[headers.zip(line.split("\t"))]
  #       yield fields
  #     end
  #   end
  # end

