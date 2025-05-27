require 'pry'
require 'bundler'
Bundler.require

require_relative './lib/game'
require_relative './lib/player'
require 'colorize'


puts "oooooooooooooooooooooooooooooooooooooooooooooo".colorize(:magenta)
puts "|   À toi qui t'aventure sur ma POO...'      |".colorize(:cyan)
puts "|       Sois prêt à combattre !!!            |".colorize(:cyan)
puts "oooooooooooooooooooooooooooooooooooooooooooooo".colorize(:magenta)


# === Initialisation du joueur humain ===
puts "\nQuel est ton prénom, vaillant combattant ?"
print "> "
user_name = gets&.chomp
my_game = Game.new(user_name)

puts "\nBienvenue, #{user_name} ! Prépare-toi au combat...\n".colorize(:green)

loop do
    my_game.new_players_in_sight   # On ajoute de nouveaux adversaires
    my_game.show_players
    puts "\n---------- | MENU | ----------".colorize(:magenta) # Affichage du menu
    my_game.menu
    choice = gets&.chomp
    my_game.menu_choice(choice)

    my_game.enemies_attack if my_game.is_still_ongoing? # Les ennemis attaquent

    break unless my_game.is_still_ongoing?
    puts "\n--- Appuie sur Entrée pour continuer ---".colorize(:magenta)
    gets
end
my_game.end_game