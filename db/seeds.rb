require 'json'
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'faker'

# ------------------------------------

puts 'Start creating cities'

uri = URI("https://sisusimulator.com.br/api/searchcity")
response = Net::HTTP.get(uri)
hash_array = JSON.parse(response)

hash_array.each do |hash|
  puts "creating #{hash['nome']}"
  Citie.create!(
    name: hash['nome'],
    slug: hash['slug'],
    state: hash['uf'],
    abstract: Faker::Lorem.paragraphs,
    bus_cost: [4, 4.5, 5, 5.5, 6].sample
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
    slug: hash['slug'],
    abstract: Faker::Lorem.paragraphs,
    website: "www.#{hash['slug']}.edu.br",
    instagram: "@#{hash['slug']}"
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
      slug_uni: hash['slugUni'],
      abstract: Faker::Lorem.paragraphs,
      internet: [true, true, true, true, false].sample,
      restaurant: [false, false, false, false, true].sample,
      accomodation: [false, false, false, false, true].sample,
      transport: [false, false, false, false, true].sample,
      sports_playground: [false, false, false, false, true].sample,
      xerox_cost: [0.2, 0.25, 0.3, 0.35, 0.4].sample,
      snack_plus_drink_price: [5, 5.5, 6, 6.5, 7, 7.5].sample,
      coffe_price: [2, 2.5, 3, 3.5].sample
    )
  end
end

puts "Campi created"

# ------------------------------------

puts "Start creating courses"

Unit.where(institution_id: 42).each do |campus|
  uri = URI("https://sisusimulator.com.br/api/searchcursoscampus.php?universidade=#{campus.slug_uni}&campus=#{campus.slug}")
  response = Net::HTTP.get(uri)
  hash_array = JSON.parse(response)

  hash_array.each do |hash|
    puts "Creating #{hash['nome']} - #{hash['tipocurso']} | #{hash['turno']}"
    Course.create!(
      unit: Unit.find_by(slug: hash['slugCampus'], slug_uni: hash['slugUni']),
      name: hash['nome'].downcase.split.map { |word| word.length >= 3 ? word.capitalize : word}.join(' '),
      degree: hash['tipocurso'],
      shift: hash['turno'],
      api_id: hash['id'],
      abstract: Faker::Lorem.paragraphs
    )
  end
end

puts "Courses created"

# ------------------------------------

puts "Start updating courses"

Course.all.each do |course|
  uri = URI("https://sisusimulator.com.br/api/curso.php?parameter=id&id=#{course.api_id}")
  response = Net::HTTP.get(uri)
  hash_array = JSON.parse(response)

  hash_array.each do |hash|
    puts "Updating #{hash['nome']} - #{hash['universidade']} | #{hash['cidade']}"
    course.update!(
      weight_lin: hash['pesoLing'],
      weight_mat: hash['pesoMat'],
      weight_ch: hash['pesoCH'],
      weight_cn: hash['pesoCN'],
      weight_red: hash['pesoRed'],
      min_lin: hash['mediaMinLin'],
      min_mat: hash['mediaMinMat'],
      min_ch: hash['mediaMinCH'],
      min_cn: hash['mediaMinCN'],
      min_red: hash['mediaMinRed'],
      min_geral: hash['mediaMinGeral'],
      bonus: hash['bonus'],
      bonus_comment: hash['bonusComentario']
    )
  end
end

puts "Courses update"

# -----------------------------------

puts "Start creating segments"

Course.all.each do |course|
  uri = URI("https://sisusimulator.com.br/api/curso.php?parameter=id&id=#{course.api_id}")
  response = Net::HTTP.get(uri)
  hash_array = JSON.parse(response)

  hash_array.each do |hash|
    hash["notasDeCorte"].each do |segment|
      puts "Creating #{segment['descricao']} - #{segment['ano']}"
      Segment.create!(
        course: course,
        name: segment['descricao'],
        sisu_edition: segment['ano'],
        score: segment['nota']
      )
    end
  end
end

puts "Segments create"

# -----------------------------------

puts "Start updating cities"

Citie.where(["id > ? OR id < ?", 484, 484]).order('id asc').each do |citie|
  puts "acessando cidade: #{citie.name}"

  html_indice = URI.open("https://pt.wikipedia.org/wiki/Lista_de_munic%C3%ADpios_do_Brasil")
  response = Nokogiri::HTML(html_indice)
  link = response.css("a:contains('#{citie.name}')")

  if link.empty?
    puts "Cidade não encontrada"
  elsif link.size > 1
    filter_link = []
    link.each { |a| filter_link << a if a["title"] =~ /(^#{citie.name}$)/ }
    path = filter_link[0]["href"] unless filter_link.empty?
  else
    path = link[0]["href"]
  end

  url = "https://pt.wikipedia.org#{path}"
  html_citie = URI.open(url)
  response = Nokogiri::HTML(html_citie)

  if response.css("tr:contains('População total') td:nth-of-type(2)").text.present?
    pop = response.css("tr:contains('População total') td:nth-of-type(2)").text
    unless pop.nil?
      pop = pop.gsub(/[^0-9]/, '').to_i
    end
  end

  if response.css("tr:contains('IDH') td:nth-of-type(2)").text.present?
    idh = response.css("tr:contains('IDH') td:nth-of-type(2)").text
    unless pop.nil?
      idh = idh.gsub(/[^0-9]/, '')
      idh = idh.to_f / (10**(idh.length - 1))
    end
  end

  if response.css("tr:nth-of-type(6) td:nth-of-type(13)").text.present?
    max_temp = response.css("tr:nth-of-type(4) td:nth-of-type(13)").text
    if max_temp.present?
      max_temp = max_temp.gsub(/[^0-9]/, '')
      if max_temp.length > 2
        max_temp = max_temp.to_f / 10
      end
    end
    min_temp = response.css("tr:nth-of-type(6) td:nth-of-type(13)").text
    if min_temp.present?
      min_temp = min_temp.gsub(/[^0-9]/, '')
      if min_temp.length > 2
        min_temp = min_temp.to_f / 10
      end
    end
  end

  if response.css("tr:nth-of-type(11) td:nth-of-type(13)").text.present?
    rain_days = response.css("tr:nth-of-type(9) td:nth-of-type(13)").text
    if rain_days.present?
      rain_days = rain_days.gsub(/[^0-9]/, '').to_f
    end
    daylight = response.css("tr:nth-of-type(11) td:nth-of-type(13)").text
    if daylight.present?
      daylight = daylight.gsub(/[^0-9]/, '')
      daylight = daylight.to_f / 10
    end
  end

  citie.update!(
    population: pop,
    idh: idh,
    max_temp_avg: max_temp,
    min_temp_avg: min_temp,
    rain_days: rain_days,
    daylight_hours: daylight
  )
  puts "#{citie.name} updated"
end

puts "Cities updated"

# -----------------------------------

puts "Start updating Campi"

csv_options = { col_sep: ';', headers: :first_row }
filepath = "db/cursos.csv"

CSV.foreach(filepath, csv_options) do |row|
  name = row['Nome do Campus']
  puts "Updating #{name}"
  ies = row['Sigla da IES']
  if ies.present?
    ies = ies.downcase
  end

  address = "#{row['Endereço'] if row['Endereço'].present?}#{", " + row['Bairro'] if row['Bairro'].present?}#{", " + row['Município'] if row['Município'].present?}"

  unit = Unit.where('name ILIKE ?', "#{name}").where('slug_uni = ?', "#{ies}")

  if unit.count == 1
    unit[0].update!(
      address: address
    )
  end
  puts "#{name} updated "
end

puts "Campi Updated"

# -----------------------------------

puts "Start updating Courses"

csv_options = { col_sep: ';', headers: :first_row }
filepath = "db/cursos.csv"

CSV.foreach(filepath, csv_options) do |row|
  campus_name = row['Nome do Campus']

  ies = row['Sigla da IES']
  if ies.present?
    ies = ies.downcase
  end

  unit = Unit.where('name ILIKE ?', "#{campus_name}").where('slug_uni = ?', "#{ies}")

  course_name = row['Nome do Curso'].downcase
  puts "Updating #{course_name}"

  degree = row['Grau']
  if degree.present?
    degree = degree.downcase
  end

  if unit.count == 1
    campus = unit[0]
    course = Course.where(unit: campus).where('lower(name) = ?', "#{course_name}").where('lower(degree) = ?', "#{degree}")
    if course.count == 1
      puts "Updating #{course_name}"
      course[0].update!(
        opening_date: row['Início Funcionamento'],
        periodization: row['Tipo de Periodicidade'],
        vacancies: row['Qt. Vagas Autorizadas'].to_i,
        hours: row['Carga Horária'].to_i,
        enade: row['Valor ENADE'],
        cpc: row['CPC Faixa'],
        cc: row['Valor CC'],
        idd: row['Valor IDD']
      )
    end
  end
  puts "#{course_name} Updated"
end

puts "Courses Updated"

# -----------------------------------

puts "Start updating institutions"

Institution.all.order('id asc').each do |ies|
  puts "acessando IES: #{ies.name}"

  html_indice = URI.open("https://pt.m.wikipedia.org/wiki/Lista_de_institui%C3%A7%C3%B5es_de_ensino_superior_do_Brasil")
  response = Nokogiri::HTML(html_indice)
  link = response.css("a:contains('#{ies.name}')")

  if link.empty?
    puts "IES não encontrada"
  elsif link.size > 1
    filter_link = []
    link.each { |a| filter_link << a if a["title"] =~ /(^#{ies.name}$)/ }
    path = filter_link[0]["href"] unless filter_link.empty?
  else
    path = link[0]["href"]
  end

  url = "https://pt.wikipedia.org#{path}"
  html_ies = URI.open(url)
  response = Nokogiri::HTML(html_ies)

  if response.css("tr:contains('Fundação') td:nth-of-type(2)").text.present?
    foundation = response.css("tr:contains('Fundação') td:nth-of-type(2)").text
  end

  if response.css("tr:contains('Graduação') td:nth-of-type(2)").text.present?
    students = response.css("tr:contains('Graduação') td:nth-of-type(2)").text
    if students.present?
      students = students.match(/.*\..{3}/)
      if students.present?
        students = students.to_s.gsub(/[^0-9]/, '').to_i
      end
    end
  end

  ies.update!(
    foundation: foundation,
    total_students: students,
  )
  puts "#{ies.name} updated"
end

puts "Institutions updated"
# -----------------------------------
