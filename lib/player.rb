require 'pry'

class Player

    attr_accessor :name, :life_points

    def initialize(name) # Méthode d'initialisation appelée à la création d'un nouvel objet Player
        @name = name   # On assigne le nom passé en paramètre à l'attribut d'instance @name
        @life_points = 10  # Tous les joueurs commencent avec 10 points de vie
    end

    def show_state   # Méthode pour afficher l'état actuel du joueur (nom et points de vie)
        puts "\n#{name} a #{life_points} points de vie"  # Affiche une phrase résumant l'état du joueur
    end

    def gets_damage(damage) # Méthode appelée quand le joueur subit des dégâts
        @life_points -= damage  # On enlève le nombre de points de dégâts aux points de vie actuels
        if life_points <= 0  # Si ses points de vie tombent à 0 ou moins
            puts "\nLe joueur #{name} a été tué !".colorize(:red)  # On affiche un message indiquant qu’il est mort
        end
    end

     
    def attacks(other_player) # Méthode pour attaquer un autre joueur
        puts "\n#{name} attaque #{other_player.name}".colorize(:light_cyan) # Message d'annonce de l'attaque
        damage = compute_damage   # Calcule les dégâts
        puts "\nIl lui inflige #{damage} points de dommages"  # Affiche les dégâts infligés
        other_player.gets_damage(damage)  # Applique les dégâts à l'autre joueur
    end

    # Méthode qui simule un lancer de dé pour déterminer les points de dégâts (entre 1 et 6)
    def compute_damage
        return rand(1..6)
    end
end

class HumanPlayer < Player

        attr_accessor :weapon_level

    def initialize(name)
        super(name)  # Appelle 'initialize(name)' de la classe Player
        @life_points = 100  # Commence à 100 points
        @weapon_level = 1  # Commence avec une arme de niveau 1
    end

    # Modification de la méthode show_state
    def show_state
        puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}"
    end

    def attacks(other_player) # Méthode pour attaquer un autre joueur
        puts "#{name} attaque #{other_player.name}".colorize(:light_cyan) # Message d'annonce de l'attaque
        damage = compute_damage * weapon_level  # Calcule les dégâts
        puts "Il lui inflige #{damage} points de dommages"  # Affiche les dégâts infligés
        other_player.gets_damage(damage)  # Applique les dégâts à l'autre joueur
    end

    def compute_damage
        return rand(1..6) * @weapon_level
    end

    def search_weapon
        new_weapon = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{new_weapon}"
        if new_weapon > @weapon_level
            @weapon_level = new_weapon
            puts "Bonne pioche ! Cette arme est + mieux bien que la tienne !".colorize(:green)
        else 
            puts "Laisse tomber, cette arme est daubée...".colorize(:blue)
        end
    end

    def search_health_pack
        health_pack = rand(1..6)
        if health_pack == 1
            puts "Tu n'as rien trouvé...".colorize(:magenta)
        elsif health_pack >= 2 || health_pack <= 5
            @life_points = @life_points + 50
            
            puts "Bravo ! T'as trouvé +50 points de vie !".colorize(:magenta)
        elsif health_pack == 6
            @life_points = @life_points + 80 

            puts "Bravo !! T'as trouvé +80 points de vie !!".colorize(:magenta)
        end 

        if @life_points > 100
            @life_points = 100
        end
    end

end
