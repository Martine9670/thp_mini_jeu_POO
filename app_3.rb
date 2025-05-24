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
user_name = gets.chomp
my_game = Game.new(user_name)

puts "\nBienvenue, #{user_name} ! Prépare-toi au combat...\n"

loop do
    my_game.new_players_in_sight   # On ajoute de nouveaux adversaires
    puts "\n---------- | MENU | ----------" # Affichage du menu
    my_game.menu
    choice = gets.chomp
    my_game.menu_choice(choice)
break unless my_game.is_still_ongoing?
end
my_game.end_game