require 'open-uri'
require 'json'

# ------------------------------------

puts 'Start creating cities'

uri = URI("https://sisusimulator.com.br/api/searchcity")
response = Net::HTTP.get(uri)
hash_array = JSON.parse(response)

hash_array.each do |hash|
  puts "creating #{hash['nome']}"
  Citie.create!(
    name: hash['nome'],
    state: hash['uf']
  )
end
puts "Cities created"

# ------------------------------------

puts "Start creating universities"

uri = URI("https://sisusimulator.com.br/api/searchuniversidades/")
response = Net::HTTP.get(uri)
hash_array = JSON.parse(response)

hash_array.each do |hash|
  puts "creating #{hash['nome'].downcase.split('-')[0].split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' ')}"
  Institution.create!(
    name: hash['nome'].downcase.split('-')[0].split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
    initials: hash['nome'].split(' - ')[1],
    slug: hash['slug']
  )
end

puts "Universities created"

# ------------------------------------

puts "Start creating campi"

Institution.all.each do |ies|
  uri = URI("https://sisusimulator.com.br/api/searchcampus.php?type=universidade&universidade=#{ies.slug}")
  response = Net::HTTP.get(uri)
  hash_array = JSON.parse(response)

  hash_array.each do |hash|
    puts "Creating #{hash['campus']}"
    Unit.create!(
      citie: Citie.find_by(name: hash['cidade'], state: hash['uf']),
      institution: Institution.find_by(slug: hash['slugUni']),
      name: hash['campus'].downcase.split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
      address: hash['campus'].downcase.split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
      slug: hash['slug'],
      slugUni: hash['slugUni']
    )
  end
end

puts "Campi created"

# ------------------------------------

puts "Start creating courses"

Unit.all.each do |campus|
  uri = URI("https://sisusimulator.com.br/api/searchcursoscampus.php?universidade=#{campus.slugUni}&campus=#{campus.slug}")
  response = Net::HTTP.get(uri)
  hash_array = JSON.parse(response)

  hash_array.each do |hash|
    puts "Creating #{hash['nome']} - #{hash['tipocurso']} | #{hash['turno']}"
    Course.create!(
      unit: Unit.find_by(slug: hash['slugCampus'], slugUni: hash['slugUni']),
      name: hash['nome'].downcase.split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
      degree: hash['tipocurso'],
      shift: hash['turno'],
      api_id: hash['id']
    )
  end
end

puts "Courses created"

# ------------------------------------

# puts "Start updating courses"

# Course.all.each do |course|
#   uri = URI("https://sisusimulator.com.br/api/curso.php?parameter=id&id=#{course.api_id}")
#   response = Net::HTTP.get(uri)
#   hash_array = JSON.parse(response)

#   hash_array.each do |hash|
#     puts "Updating #{hash['nome']} - #{hash['universidade']} | #{hash['cidade']}"
#     course.update!(
#       weight_lin: hash['pesoLing'],
#       weight_mat: hash['pesoMat'],
#       weight_ch: hash['pesoCH'],
#       weight_cn: hash['pesoCN'],
#       weight_red: hash['pesoRed'],
#       min_lin: hash['mediaMinLin'],
#       min_mat: hash['mediaMinMat'],
#       min_ch: hash['mediaMinCH'],
#       min_cn: hash['mediaMinCN'],
#       min_red: hash['mediaMinRed'],
#       min_geral: hash['mediaMinGeral'],
#       bonus: hash['bonus'],
#       bonus_comment: hash['bonusComentario']
#     )
#   end
# end

# puts "Courses update"

# -----------------------------------
