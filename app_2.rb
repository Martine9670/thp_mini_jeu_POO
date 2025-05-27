require 'pry'
require 'bundler'
Bundler.require

require_relative './lib/game'
require_relative './lib/player'

puts "oooooooooooooooooooooooooooooooooooooooooooooo".colorize(:magenta)
puts "|   À toi qui t'aventure sur ma POO...'      |".colorize(:cyan)
puts "|       Sois prêt à combattre !!!            |".colorize(:cyan)
puts "oooooooooooooooooooooooooooooooooooooooooooooo".colorize(:magenta)

# === Initialisation du joueur humain ===
puts "\nQuel est ton prénom, vaillant combattant ?"
print "> ".colorize(:green)
user_name = gets.chomp
user = HumanPlayer.new(user_name)

puts "\nBienvenue, #{user_name} ! Prépare-toi au combat...\n"

puts "----------------------------------------------------\n"

player1 = Player.new("Josiane")
player2 = Player.new("José")
Players = [player1, player2]

while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0)
    user.show_state
  puts "\n---------- | MENU | ----------" # Affichage du menu
  puts "\nQuelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"

# Affichage de l'état des ennemis
  if player1.life_points > 0
    puts "0 - #{player1.name} a #{player1.life_points} points de vie"
  end
  if player2.life_points > 0
    puts "1 - #{player2.name} a #{player2.life_points} points de vie"
  end

  # Lecture du choix de l'utilisateur
  print "> "
  choice = gets.chomp

  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  when "0"
    if player1.life_points > 0
      user.attacks(player1)
    else
      puts "#{player1.name} est déjà mort !"
    end
  when "1"
    if player2.life_points > 0
      user.attacks(player2)
    else
      puts "#{player2.name} est déjà mort !"
    end
  else
    puts "Choix invalide, essaie encore."
  end

  # Tour des ennemis (s'ils sont encore en vie)
  puts "\nLes autres joueurs t'attaquent !" if player1.life_points > 0 || player2.life_points > 0
  player1.attacks(user) if player1.life_points > 0
  player2.attacks(user) if player2.life_points > 0
end

puts "\n ----- Fin du combat -----"
    if user.life_points > 0 && Players.all? { |player| player.life_points <= 0 }
    puts "Excellent !! Tu as gagné !!"
    elsif user.life_points <= 0
    puts "Loser !! T'es mort...!"
    else
    puts "Le combat continue !"
    end

