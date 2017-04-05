# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w(
  L0ck3
  Ronan
  Todiann
  Chèvre
  Coquillette
  François
  Alexandre
  Hugo
  Flix
  Martin
  Nath
  Jean-Bertand
  Didier
  Jun
  Adrien
  Parsy
  Hafsa
  Flexbox
  Patrick
  Bob
  Joseph
  Amaury
).each { |nick| User.create(nickname: nick) }