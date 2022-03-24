require './views/Info_Players.rb'
require './views/First_Player.rb'
require './models/Player.rb'

require 'fox16'
include Fox

class WindowPlayers < FXMainWindow
   def initialize(app, management)
      super(app,"Scrabble",:width=> 300, :height => 200,:opts=> DECOR_ALL)
      @contPlayer = 1
      @numberOfPlayers = ""
      @management = management

      vFrame = FXVerticalFrame.new(self, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
      hFrame1 = FXHorizontalFrame.new(vFrame,LAYOUT_CENTER_X|FRAME_RAISED)
      FXLabel.new(hFrame1, "Número de jugadores (2-4):")
      txtNumPlayers = FXTextField.new(hFrame1, 4)
      txtNumPlayers.connect(SEL_LEFTBUTTONPRESS) do
        txtNumPlayers.text = ""
      end
      txtNumPlayers.text = "2"
      
      hFrame2 = FXHorizontalFrame.new(vFrame,LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
      lblMsg = FXLabel.new(hFrame2, "¡BIENVENIDOS!")
      lblMsg.textColor = Fox.FXRGB( 46, 139,  87)
      lblMsg.justify = 3
      
      hFrame3 = FXHorizontalFrame.new(vFrame,LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
      btnContinue = FXButton.new(hFrame3, "Continuar")
      btnContinue.connect(SEL_COMMAND) do
        @numberOfPlayers = txtNumPlayers.to_s.to_i
        if @numberOfPlayers >= 2 and @numberOfPlayers <= 4
          # for i in 1..numberOfPlayers do
          # while @contPlayer <
            @management.fillWords()
            @management.fillBag()
            infoPlayers = InfoPlayers.new(app, @contPlayer, method(:infoPlayer))
            infoPlayers.create
            infoPlayers.show
            # @nextPlayer = false
            # close(PLACEMENT_SCREEN)
          # end 
        else
          lblMsg.text = "Mínimo 2 y máximo 4 jugadores"
          lblMsg.textColor = Fox.FXRGB(205,  92,  92)
        end
      end
   end
   def infoPlayer(name, isBot)
    @management.createPlayer(name.to_s, isBot)
    if @contPlayer < @numberOfPlayers 
      @contPlayer = @contPlayer + 1
      infoPlayers = InfoPlayers.new(app, @contPlayer, method(:infoPlayer))
      infoPlayers.create
      infoPlayers.show
    else
      firstPlayer = FirstPlayer.new(app, @management)
      firstPlayer.create
      firstPlayer.show
      close()
    end
   end
   def create
       super
       show(PLACEMENT_SCREEN)
   end
 end