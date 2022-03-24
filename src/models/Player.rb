class Player  
  attr_accessor :name, :deckOfgameTokens, :score, :firstToken, :isRobot

  # método inicializar clase
  def initialize(name, deckOfgameTokens, score, firstToken, isRobot)  
    # atributos   
    @name = name 
    @deckOfgameTokens = deckOfgameTokens
    @score = score
    @firstToken = firstToken
    @isRobot = isRobot
  end  
end  