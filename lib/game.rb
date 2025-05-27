class Game
  attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight

  def initialize(human_name) # Initialise une nouvelle partie
    @human_player = HumanPlayer.new(human_name) # Création du joueur humain
    @enemies = [] # Initialise une liste vide d'ennemis
    4.times do |i| # Création de 4 ennemis au début du jeu
      @enemies << Player.new("Enemy_#{i + 1}") # Chaque ennemi a un nom unique
    end
    @players_left = 10 # Nombre total d'ennemis
    @enemies_in_sight = []
  end

  def kill_player(player) # Supprime un joueur s'il est mort
    if @enemies.include?(player) # Vérifie que l'ennemi existe
      @enemies.delete(player) # Supprime l'ennemi de la liste
      puts "\n#{player.name} a été éliminé".colorize(:red) # Confirme la suppression de l'ennemi
    else
      puts "\n#{player.name} n'est pas un ennemi connu"
    end
  end

  def is_still_ongoing? # Vérifie si la partie est toujours en cours
    @human_player.life_points > 0 && !@enemies.empty? # La partie continue si le joueur humain est vivant et qu'il reste un ennemi
  end

  def show_players 
    puts "\nVoici l'état de chaque joueur :".colorize(:yellow) # Affiche l'état du joueur
    @human_player.show_state # Affiche l'état du joueur
    remaining_enemies = enemies.count { |enemy| enemy.life_points > 0 } # Compte les ennemis vivants
    puts "\nNombre d'ennemis restants : #{remaining_enemies}"
  end

  def alive_enemies
    @enemies.select { |e| e.life_points > 0 }
  end

  def menu
    puts "\n--- Quelle action veux-tu effectuer ? ---".colorize(:yellow)
    puts "a - Chercher une meilleure arme".colorize(:green)
    puts "s - Chercher à se soigner".colorize(:green)
    puts "q - Quitter la partie".colorize(:red)
    puts "--- Attaquer un joueur en vue : ---".colorize(:yellow)

    alive_enemies.each_with_index do |ennemi, index|
      puts "\n#{index} - #{ennemi.name} (#{ennemi.life_points} PV)"
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    when "q"
      puts "\nQuoi !?!? Tu fuis ?? Honte sur toi...\n\n".colorize(:yellow)
      exit
    when "0".."9"
      index = choice.to_i
      if enemy = alive_enemies[index]
        @human_player.attacks(enemy)
        kill_player(enemy) if enemy.life_points <= 0
      else
        puts "\nCet ennemi n'existe pas."
      end
    else
      puts "\nChoix invalide, veuillez réessayer."
    end
  end

def enemies_attack
  return if @human_player.life_points <= 0 

  puts "\n=== Les ennemis ripostent ! ===".colorize(:red)
  @enemies.each do |enemy|
    break if @human_player.life_points <= 0 # Attaque stoppée si le joueur humain est mort
    enemy.attacks(@human_player) if enemy.life_points > 0
  end
end

  def end_game
    puts "\nLe combat est terminé !"
    if @human_player.life_points > 0
      puts "\n---- | Excellent, tu as gagné !! | ----".colorize(:green)
      puts ""
    else
      puts "\nLoser !! T'es mort...".colorize(:red)
      puts ""
    end
  end

  def play
    while is_still_ongoing?
      show_players
      menu
      print "> "
      choice = gets&.chomp
      menu_choice(choice)
      enemies_attack if is_still_ongoing? # Les ennemis attaquent si le jeu est toujours en cours
      new_players_in_sight if @players_left > 0 # Ajoute de nouvveaux ennemis
    end
    end_game
  end

  def new_players_in_sight # Détecte s'il y a de nouveaux ennemis à faire apparaitre
    if @enemies_in_sight.length >= @players_left # Si tous les joueurs restants sont déjà visibles
      puts "\nTous les joueurs sont déjà en vue"
    else
      roll_dice # Sinon on lance le dé
    end
  end

def roll_dice # Méthode pour faire apparaître de nouveaux ennemis avec un lancer de dé
  result = rand(1..6)
  puts "\nRésultat du dé : #{result}"

  case result
    when 1
      puts "\nAucun nouveau joueur adverse n'arrive."
    when 2..4
      enemy = Player.new("Player_#{rand(1000..9999)}")
      puts "\nUn nouvel ennemi arrive : #{enemy.name}"
      @enemies_in_sight << enemy
      @enemies << enemy
      @players_left -= 1
    when 5..6
      2.times do
        break if @players_left <= 0 # Ne pas dépasser le nombre de joueurs restantss
        enemy = Player.new("Player_#{rand(1000..9999)}")
        puts "\nUn nouvel ennemi arrive : #{enemy.name}"
        @enemies_in_sight << enemy
        @enemies << enemy
        @players_left -= 1
      end
    end
  end
end
