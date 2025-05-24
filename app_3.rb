require 'pry'
require 'bundler'
Bundler.require

require_relative './lib/game'
require_relative './lib/player'


puts "------------------------------------------------------"
puts "| Bienvenue sur 'ILS VEULENT TOUS MA POO' !!'        |"
puts "| Le but du jeu est d'être le dernier survivant !    |"
puts "------------------------------------------------------"

# === Initialisation du joueur humain ===
puts "\nQuel est ton prénom, vaillant combattant ?"
print "> "
user_name = gets.chomp.to_s
my_game = Game.new(user_name)

puts "\nBienvenue, #{user_name} ! Prépare-toi au combat...\n"
