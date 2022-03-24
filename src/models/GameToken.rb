class GameToken  

    attr_accessor :symbol, :value, :available, :isUsed
    # método inicializar clase
    def initialize(symbol, value, available, isUsed)  
      # atributos   
      @symbol = symbol
      @value = value
      @available = available
      @isUsed = isUsed
    end
  end  