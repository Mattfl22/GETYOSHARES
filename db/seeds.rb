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

puts "Creating users..."

users_path = Rails.root.join("db/seeds/csv/users.csv")
users = {}

# {
#   "1" => <User id=345, first_name="bob", ...>,
#   "2" => <User id=346, first_name="janis", ...>,
# }

CSV.foreach(users_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :first_name,
    :last_name,
    :artist_name,
    :country,
    :date_of_birth,
    :email,
    :password
  )

  user = User.new(attributes)
  file = File.open(Rails.root.join("db/seeds/images/users/#{row[:picture_filename]}"))
  user.picture.attach(io: file, filename: row[:picture_filename], content_type: 'image/jpeg')
  user.save!

  users[row[:id]] = user
end

puts "Creating projects..."

projects_path = Rails.root.join("db/seeds/csv/projects.csv")
projects = {}

# {
#   "1" => <Project id=123, user_id=345, ...>,
#   "2" => <Project id=124, user_id=345, ...>,
# }

CSV.foreach(projects_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :distributor,
    :name,
    :description,
    :release_date,
    :average_distribution_share,
    :expected_audio_streams_year,
    :expected_video_streams_year,
    :number_of_tokens
  )

  project = Project.new(attributes)
  project.user = users[row[:user_id]]

  file = File.open(Rails.root.join("db/seeds/images/projects/#{row[:picture_filename]}"))
  project.picture.attach(io: file, filename: row[:picture_filename], content_type: 'image/jpeg')
  project.save!

  projects[row[:id]] = project
end

puts "Creating products..."

products_path = Rails.root.join("db/seeds/csv/products.csv")
products = {}

CSV.foreach(products_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :upc,
    :grid,
    :title,
    :language,
    :format,
    :genre,
    :spotify_id,
  )

  product = Product.new(attributes)
  product.project = products[row[:project_id]]
  project.create!

  products[row[:id]] = product
end

puts "Creating tracks..."

tracks_path = Rails.root.join("db/seeds/csv/tracks.csv")
tracks = {}

CSV.foreach(tracks_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :ISRC,
    :grid,
    :title,
    :featuring,
    :spotify_id,
    :youtube_id,
  )

  track = Track.new(attributes)
  track.product = tracks[row[:product_id]]
  track.create!

  tracks[row[:id]] = track
end

puts "Creating tokens..."

tokens_path = Rails.root.join("db/seeds/csv/tokens.csv")
tokens = {}

CSV.foreach(tokens_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :unit_price,
  )

  token = Token.new(attributes)
  token.project = tokens[row[:project_id]]
  token.create!

  tokens[row[:id]] = token
end

puts "Creating transactions..."

transactions_path = Rails.root.join("db/seeds/csv/transactions.csv")
transactions = {}

CSV.foreach(transactions_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :comment,
    :rating,
    :date,
    :active,
  )

  transaction = Transaction.new(attributes)
  transaction.token = transactions[row[:token_id]]
  transaction.user = transactions[row[:user_id]]
  transaction.create!

  transactions[row[:id]] = transaction
end

puts "Creating revenues..."

revenues_path = Rails.root.join("db/seeds/csv/revenues.csv")
revenues = {}

CSV.foreach(revenues_path, headers: :first_row, col_sep: ';', header_converters: :symbol) do |row|
  attributes = row.slice(
    :date,
    :revenue,
  )

  revenue = Revenue.new(attributes)
  revenue.project = revenues[row[:project_id]]
  revenue.create!

  revenues[row[:id]] = revenue
end

puts 'All done'
