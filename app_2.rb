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
user = HumanPlayer.new(user_name)

puts "\nBienvenue, #{user} ! Prépare-toi au combat...\n"

enemy1 = Player.new("Josiane")
enemy2 = Player.new("José")
enemies = [enemy1, enemy2]

while user.life_points >0 && (enemy1.life_points > 0 || enemy2.life_points >0)
    user.show_state
    # Affichage du menu
  puts "\nQuelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "attaquer un joueur en vue :"

# Affichage de l'état des ennemis
  if enemy1.life_points > 0
    puts "0 - #{enemy1.name} a #{enemy1.life_points} points de vie"
  end
  if enemy2.life_points > 0
    puts "1 - #{enemy2.name} a #{enemy2.life_points} points de vie"
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
    if enemy1.life_points > 0
      user.attacks(enemy1)
    else
      puts "#{enemy1.name} est déjà mort !"
    end
  when "1"
    if enemy2.life_points > 0
      user.attacks(enemy2)
    else
      puts "#{enemy2.name} est déjà mort !"
    end
  else
    puts "Choix invalide, essaie encore."
  end

  # Tour des ennemis (s'ils sont encore en vie)
  puts "\nLes autres joueurs t'attaquent !" if enemy1.life_points > 0 || enemy2.life_points > 0
  enemy1.attacks(user) if enemy1.life_points > 0
  enemy2.attacks(user) if enemy2.life_points > 0
end

puts "\n ----- Fin du combat -----"
if user.life_points > 0 && enemies.all? { |enemy| enemy.life_points <= 0 }
  puts "Bravo !! Tu as gagné !!"
elsif user.life_points <= 0
  puts "Loser ! T'es mort...!"
else
  puts "Le combat continue !"
end

