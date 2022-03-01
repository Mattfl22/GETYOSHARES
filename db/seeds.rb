# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

puts "Clean db"
puts "OK let's go bitches ! Creating users..."

users_path = Rails.root.join("db/seeds/csv/users.csv")
users = {}

# {
#   "1" => <User id=345, first_name="bob", ...>,
#   "2" => <User id=346, first_name="janis", ...>,
# }

CSV.foreach(users_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = {
    first_name: row[:first_name],
    last_name: row[:last_name],
    artist_name: row[:artist_name],
    country: row[:country],
    date_of_birth: row[:date_of_birth],
    email: row[:email],
    password: row[:password]
  }

  user = User.new(attributes)
  file = File.open(Rails.root.join("db/seeds/images/users/#{row[:photo_url]}"))
  user.photo.attach(io: file, filename: row[:photo_url], content_type: 'image/jpeg')
  user.save!

  users[row[:id]] = user
end

puts "lol Marie's picture... shame doesn't kill, right ? "
puts "Ok, users created. Nice bunch of losers."

puts "Creating projects..."

projects_path = Rails.root.join("db/seeds/csv/projects.csv")
projects = {}

CSV.foreach(projects_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  headers = [
    "distributor",
    "name",
    "description",
    "release_date",
    "average_distribution_share",
    "expected_audio_streams_year",
    "expected_video_streams_year",
    "number_of_tokens"
  ]

  attributes = {}

  headers.each do |header|
    attributes[header.to_sym] = row[header.to_sym]
  end

  project = Project.new(attributes)
  project.user = users[row[:user_id]]

  file = File.open(Rails.root.join("db/seeds/images/projects/#{row[:picture_filename]}"))
  project.photo.attach(io: file, filename: row[:picture_filename], content_type: 'image/jpeg')
  project.save!

  projects[row[:id]] = project
end

puts "Projects created... but frankly, I'd prefer invest in anything than that... "

puts "Let's move on... Creating products..."

products_path = Rails.root.join("db/seeds/csv/products.csv")
products = {}

CSV.foreach(products_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  headers = ["upc", "grid", "title", "language", "format", "genre", "spotify_id"]

  attributes = {}

  headers.each do |header|
    attributes[header.to_sym] = row[header.to_sym]
  end

  product = Product.new(attributes)
  product.project = projects[row[:project_id]]
  product.save!

  products[row[:id]] = product
end

puts "Ok for products !"

puts "Creating tracks now... "

tracks_path = Rails.root.join("db/seeds/csv/tracks.csv")
tracks = {}

CSV.foreach(tracks_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  headers = ["isrc", "grid", "title", "featuring", "spotify_id", "youtube_id"]
  attributes = {}

  headers.each do |header|
    attributes[header.to_sym] = row[header.to_sym]
  end

  track = Track.new(attributes)
  track.product = products[row[:product_id]]
  track.save!

  tracks[row[:id]] = track
end

puts "Oh."
puts "My."
puts 'God.'
puts "Pfew, you'd need to pay me for listening to that shit lol"
puts 'OK, your... "songs"... are created.'

puts "Creating tokens now..."

tokens_path = Rails.root.join("db/seeds/csv/tokens.csv")
tokens = {}

CSV.foreach(tokens_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = {
    unit_price: row[:unit_price]
  }

  token = Token.new(attributes)
  token.project = projects[row[:project_id]]
  token.save!

  tokens[row[:id]] = token
end

puts "zzzzZZZZZZzzzZZZzzzzzZZzzzz...."
puts "Creating transactions..."

transactions_path = Rails.root.join("db/seeds/csv/transactions.csv")
transactions = {}

CSV.foreach(transactions_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  headers = ["comment", "rating", "date", "active"]

  attributes = {}

  headers.each do |header|
    attributes[header.to_sym] = row[header.to_sym]
  end

  transaction = Transaction.new(attributes)
  transaction.token = tokens[row[:token_id]]
  transaction.user = users[row[:user_id]]
  transaction.save!

  transactions[row[:id]] = transaction
end

puts "OK done"
puts "And FINALLY creating revenues..."

revenues_path = Rails.root.join("db/seeds/csv/revenues.csv")
revenues = {}

CSV.foreach(revenues_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  headers = ["date", "revenue"]

  attributes = {}

  headers.each do |header|
    attributes[header.to_sym] = row[header.to_sym]
  end

  revenue = Revenue.new(attributes)
  revenue.project = projects[row[:project_id]]
  revenue.save!

  revenues[row[:id]] = revenue
end

puts "All done !!!! YEAAAH !! I think i've lost 21 grams..."
