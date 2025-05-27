class Game
  attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight

  def initialize(human_name)
    @human_player = HumanPlayer.new(human_name)
    @enemies = []
    4.times do |i|
      @enemies << Player.new("Enemy_#{i + 1}")
    end
    @players_left = 10
    @enemies_in_sight = []
  end

  def kill_player(player)
    if @enemies.include?(player)
      @enemies.delete(player)
      puts "\n#{player.name} a été éliminé"
    else
      puts "\n#{player.name} n'est pas un ennemi connu"
    end
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && !@enemies.empty?
  end

  def show_players
    puts "\nVoici l'état de chaque joueur :"
    @human_player.show_state

    remaining_enemies = enemies.count { |enemy| enemy.life_points > 0 }
    puts "\nNombre d'ennemis restants : #{remaining_enemies}"
  end

  def alive_enemies
    @enemies.select { |e| e.life_points > 0 }
  end

  def menu
    puts "\n--- Quelle action veux-tu effectuer ? ---"
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner"
    puts "q - Quitter la partie"
    puts "--- Attaquer un joueur en vue : ---"

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
      puts "\nQuoi?? Tu fuis ?? Honte sur toi..."
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

  puts "\n=== Les ennemis ripostent ! ==="
  @enemies.each do |enemy|
    break if @human_player.life_points <= 0
    enemy.attacks(@human_player) if enemy.life_points > 0
  end
end

  def end_game
    puts "\nLe combat est terminé !"
    if @human_player.life_points > 0
      puts "\n---- | Bravo, tu as gagné !! | ----"
      puts ""
    else
      puts "\nLoser... Tu as perdu."
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
      enemies_attack if is_still_ongoing?
      new_players_in_sight if @players_left > 0
    end
    end_game
  end

  def new_players_in_sight
    if @enemies_in_sight.length >= @players_left
      puts "\nTous les joueurs sont déjà en vue"
    else
      roll_dice
    end
  end

def roll_dice
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
        break if @players_left <= 0
        enemy = Player.new("Player_#{rand(1000..9999)}")
        puts "\nUn nouvel ennemi arrive : #{enemy.name}"
        @enemies_in_sight << enemy
        @enemies << enemy
        @players_left -= 1
      end
    end
  end
end
