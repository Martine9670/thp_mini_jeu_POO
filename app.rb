require 'pry'
require 'bundler'
Bundler.require

require_relative './lib/game'
require_relative './lib/player'

# 1. Création des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")

# 2. Affichage de l'état des joueurs
puts "--- Voici l'état de chaque joueur :\n\n"
player1.show_state
player2.show_state
puts ""

# 3. Début du combat
puts "--- Passons à la phase d'attaque :\n"

# 4. Combat jusqu'à la mort
while player1.life_points > 0 && player2.life_points > 0
    puts "\n----- Nouveau tour -----"
  # Affichage de l'état de chaque joueur avant chaque tour
  player1.show_state
  player2.show_state
  puts ""

  # Josiane attaque d'abord
  player1.attacks(player2)
  break if player2.life_points <= 0  # Si José est mort, on termine la boucle

  # José attaque ensuite
  player2.attacks(player1)
  break if player1.life_points <= 0  # Si Josiane est morte, on termine la boucle
end

# À la fin de la boucle, affiche l'état final des joueurs
puts "\n ----- Fin du combat -----"
if player1.life_points <= 0
  puts "Le joueur Josiane a perdu !"
elsif player2.life_points <= 0
  puts "Le joueur José a perdu !"
end


binding.pry