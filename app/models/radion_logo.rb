class Animation

    def self.frame_one
        puts "
        88888888ba                        88  88                            
        ".colorize(:red)
        sleep (0.2)
        system "clear"
    end

    def self.frame_two
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_three
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_four
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_five
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
        88''''88'            Y8  a8     `Y88  88  a8       8a  88P      8a  
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_six
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
        88''''88'            Y8  a8     `Y88  88  a8       8a  88P      8a  
        88    `8b    ,adPPPPP88  8b       88  88  8b       d8  88       88  
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_seven
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
        88''''88'            Y8  a8     `Y88  88  a8       8a  88P      8a  
        88    `8b    ,adPPPPP88  8b       88  88  8b       d8  88       88  
        88     `8b   88,    ,88   8a,   ,d88  88   8a,   ,a8   88       88  
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

    def self.frame_eight
        puts "
        88888888ba                        88  88                            
        88      '8b                       88  ''                            
        88      ,8P                       88                                
        88aaaaaa8P'  ,adPPYYba,   ,adPPYb,88  88   ,adPPYba,   8b,dPPYba,   
        88''''88'            Y8  a8     `Y88  88  a8       8a  88P      8a  
        88    `8b    ,adPPPPP88  8b       88  88  8b       d8  88       88  
        88     `8b   88,    ,88   8a,   ,d88  88   8a,   ,a8   88       88  
        88      `8b    8bbdP Y8     8bbdP Y8  88     YbbdP     88       88   
        ".colorize(:red)

        sleep (0.2)
        system "clear"
    end

 

    def self.animation
        3.times do
          Animation.frame_one
          Animation.frame_two
          Animation.frame_three
          Animation.frame_four
          Animation.frame_six
          Animation.frame_seven
          Animation.frame_eight
        end
      end

end