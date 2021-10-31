require 'open-uri'
require 'json'

# puts "Cleaning up database..."
# Model.destroy_all
# puts "Database cleaned"

# ------------------------------------

# puts "Start creating states"

# uri = URI("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
# response = Net::HTTP.get(uri)
# hash_array = JSON.parse(response)

# hash_array.each do |hash|
#   puts "creating #{hash['nome']}"
#   State.create!(
#     name: hash['nome'],
#     initials: hash['sigla']
#   )
# end
# puts "States created"

# ------------------------------------

# puts "Start creating cities"

# uri = URI("https://sisusimulator.com.br/api/searchcity")
# response = Net::HTTP.get(uri)
# hash_array = JSON.parse(response)

# hash_array.each do |hash|
#   puts "creating #{hash['nome']}"
#   Citie.create!(
#     state: State.find_by(initials: hash["uf"]),
#     name: hash['nome']
#   )
# end
# puts "Cities created"

# ------------------------------------

# puts "Start creating universities"

# uri = URI("https://sisusimulator.com.br/api/searchuniversidades/")
# response = Net::HTTP.get(uri)
# hash_array = JSON.parse(response)

# hash_array.each do |hash|
#   puts "creating #{hash['nome'].downcase.split('-')[0].split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' ')}"
#   Institution.create!(
#     name: hash['nome'].downcase.split('-')[0].split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
#     initials: hash['slug'].upcase
#   )
# end

# puts "Universities created"

# ------------------------------------
