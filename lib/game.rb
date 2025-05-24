require 'pry'
require_relative 'player'


class Game

    attr_accessor :human_player, :enemies

    def initialize(human_name)
        @human_player = HumanPlayer.new(human_name)
        @enemies = []
        4.times do |i|
        @enemies << Player.new("Enemy_#{i + 1}")
        end
    end

     def kill_player(player)
        if @enemies.include?(player)
            @enemies.delete(player)
            puts "#{player.name} a été éliminé"
        else
            puts "#{player.name} n'est pas un ennemi connu"
        end
    end

    def is_still_ongoing?
        @human_player.life_points > 0 && !@enemies.empty?
    end

    def show_players
        puts "Voici l'état de chaque joueur :"
        @human_player.show_state

        remaining_enemies = enemies.count { |enemy| enemy.life_points > 0 }

        puts "Nombre d'ennemis restants : #{remaining_enemies}"    
    end

    def menu

        # Affichage du menu
        puts "\nQuelle action veux-tu effectuer ?"
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner"
        puts "f - attaquer un joueur en vue :"

        @enemies.each_with_index do |ennemi, index|
        if ennemi.life_points > 0
        puts "#{index} - #{ennemi.name}"
        end
    end
end

    # Méthode pour gérer les choix du menu
    def menu_choice(choice)
        case choice
            when "a"
                @human_player.search_weapon
            when "s"
                @human_player.search_health_pack
            when "0".."9"
                index = choice.to_i
                if enemy = @enemies[index]
                @human_player.attacks(enemy)
                kill_player(enemy) if enemy.life_points <= 0
                else
                puts "Cet ennemi n'existe pas."
                end
            else
                puts "Choix invalide, veuillez réessayer."
        end
    end

    # Méthode pour faire riposter les ennemis vivants
    def enemies_attack
        @enemies.each do |enemy|
            if enemy.life_points > 0
            enemy.attacks(@human_player)
            end
        end
    end

    # Méthode de fin du jeu
    def end_game
        puts "Le jeu est fini."
        if @human_player.life_points > 0
            puts "Bravo, tu as gagné !"
        else
            puts "Loser... Tu as perdu."
        end
    end

    def play
        while is_still_ongoing?
            show_players
            menu
            print "> "
            choice = gets.chomp
            menu_choice(choice)
            enemies_attack if is_still_ongoing?
        end
    end
end

binding.pry