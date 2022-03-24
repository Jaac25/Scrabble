require './models/GameToken.rb'

class Bag  
    
    # método inicializar clase
    def initialize()  
      # atributos   
      @gameTokens = fillBag()
    end
    
    def getTokens()
        return @gameTokens
    end

    def fillBag()
        gameTokens = []
        # for i in 1..2 do
        #     gameToken = GameToken.new(" ", 0, true, false)
        #     gameTokens << gameToken
        # end
        for i in 1..12 do
            gameToken = GameToken.new("A", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..2 do
            gameToken = GameToken.new("B", 3, true, false)
            gameTokens << gameToken
        end
        for i in 1..4 do
            gameToken = GameToken.new("C", 3, true, false)
            gameTokens << gameToken
        end
        #
        for i in 1..1 do
            gameToken = GameToken.new("CH", 5, true, false)
            gameTokens << gameToken
        end
        #
        for i in 1..5 do
            gameToken = GameToken.new("D", 2, true, false)
            gameTokens << gameToken
        end
        for i in 1..12 do
            gameToken = GameToken.new("E", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("F", 4, true, false)
            gameTokens << gameToken
        end
        for i in 1..2 do
            gameToken = GameToken.new("G", 2, true, false)
            gameTokens << gameToken
        end
        for i in 1..2 do
            gameToken = GameToken.new("H", 4, true, false)
            gameTokens << gameToken
        end
        for i in 1..6 do
            gameToken = GameToken.new("I", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("J", 8, true, false)
            gameTokens << gameToken
        end
        for i in 1..4 do
            gameToken = GameToken.new("L", 1, true, false)
            gameTokens << gameToken
        end
        #
        for i in 1..1 do
            gameToken = GameToken.new("LL", 8, true, false)
            gameTokens << gameToken
        end
        #
        for i in 1..2 do
            gameToken = GameToken.new("M", 3, true, false)
            gameTokens << gameToken
        end
        for i in 1..5 do
            gameToken = GameToken.new("N", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("Ñ", 8, true, false)
            gameTokens << gameToken
        end
        for i in 1..9 do
            gameToken = GameToken.new("O", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..2 do
            gameToken = GameToken.new("P", 3, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("Q", 5, true, false)
            gameTokens << gameToken
        end
        for i in 1..5 do
            gameToken = GameToken.new("R", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("RR", 8, true, false)
            gameTokens << gameToken
        end
        for i in 1..6 do
            gameToken = GameToken.new("S", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..4 do
            gameToken = GameToken.new("T", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..5 do
            gameToken = GameToken.new("U", 1, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("V", 4, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("X", 8, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("Y", 4, true, false)
            gameTokens << gameToken
        end
        for i in 1..1 do
            gameToken = GameToken.new("Z", 10, true, false)
            gameTokens << gameToken
        end
        @gameTokens = gameTokens
    end
  end  