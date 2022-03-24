require './views/Board.rb'
require 'fox16'
include Fox

class FirstPlayer < FXMainWindow
   def initialize(app, management)
        super(app, "Primer jugador", :width=> 300, :height => 150)
        firstPlayer = management.getFirstPlayer()
        players = management.getPlayers()
        index = firstPlayer

        frameMsg = FXVerticalFrame.new(self, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)

        frameName = FXHorizontalFrame.new(frameMsg, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH|FRAME_RAISED)
        frameMsgName = FXVerticalFrame.new(frameName, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
        lblMsg = FXLabel.new(frameMsgName, "El primer jugador es: ")
        lblName = FXLabel.new(frameName, players[firstPlayer].name)
        lblName.textColor = Fox.FXRGB( 25,  25, 112)
        fontName = FXFont.new(app, "name", 15)
        lblName.font = fontName

        frameToken = FXHorizontalFrame.new(frameMsg, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH|FRAME_RAISED)
        frameMsgToken = FXVerticalFrame.new(frameToken, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
        lblMsgToken = FXLabel.new(frameMsgToken, "Obtuvo la ficha: ")
        lblToken = FXLabel.new(frameToken, management.getSymbolByIndex(players[firstPlayer].firstToken))
        lblToken.textColor = Fox.FXRGB( 32, 178, 170)
        fontToken = FXFont.new(app, "token", 15)
        lblToken.font = fontToken

        frameButton = FXHorizontalFrame.new(frameMsg, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
        btnContinue = FXButton.new(frameButton, "Continuar")
        btnContinue.connect(SEL_COMMAND) do
          management.createBoard()
          board = Board.new(app, management, firstPlayer, 1, [], "", 0)
          board.create
          board.show
          close(PLACEMENT_SCREEN)
        end
   end
   def create
       super
       show(PLACEMENT_SCREEN)
   end
 end
