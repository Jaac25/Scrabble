#require '../control/Control.rb'
require './views/First_Player.rb'

require 'fox16'
include Fox

class InfoPlayers < FXMainWindow
   def initialize(app, player, infoPlayers)
    super(app, "Players", :width=> 350, :height => 300)
    @infoPlayers = infoPlayers
    @namePlayer = ""
    @isBot = false
    
    vFrame = FXVerticalFrame.new(self, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
    frameTitulo = FXHorizontalFrame.new(vFrame,LAYOUT_CENTER_X)
    lblMsg = FXLabel.new(frameTitulo, "Jugador #{player}")
    lblMsg.textColor = Fox.FXRGB(  0, 104, 139)
    fontMsg = FXFont.new(app, "msg", 20)
    lblMsg.font = fontMsg
    frameH = FXHorizontalFrame.new(vFrame,LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH|FRAME_RAISED)
    FXLabel.new(frameH, "Jugador #{player}: ")
    txtNameOfPlayer = FXTextField.new(frameH, 15)
    txtNameOfPlayer.text = "Humano #{player}"
    txtNameOfPlayer.connect(SEL_LEFTBUTTONPRESS) do
      txtNameOfPlayer.text = ""
    end
    @namePlayer = txtNameOfPlayer
    btnType = FXButton.new(frameH, @isBot ? "Bot": "Human", nil,nil, 0,LAYOUT_FIX_WIDTH,0, 0, 45, 20)
    btnType.backColor = @isBot ? Fox.FXRGB(255,  0,  0) : Fox.FXRGB(151, 255, 255)
    btnType.connect(SEL_COMMAND) do
      @isBot = !@isBot
      btnType.backColor = @isBot ? Fox.FXRGB(255,  0,  0) : Fox.FXRGB(151, 255, 255)
      btnType.text = @isBot ? "Bot": "Human"
      txtNameOfPlayer.text = @isBot ? "Robot #{player}" : "Humano #{player}"
    end
    frameH = FXHorizontalFrame.new(vFrame, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
    lblMsg = FXLabel.new(frameH, "")
    
    frameH2 = FXHorizontalFrame.new(vFrame, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
    btnContinue = FXButton.new(frameH2, "Continuar")
    btnContinue.connect(SEL_COMMAND) do
      if @namePlayer.to_s == ""
        lblMsg.text = "Introduce el nombre"
        lblMsg.textColor = Fox.FXRGB(205,  92,  92)
      else
        @infoPlayers.call(@namePlayer, @isBot)
        close()
      end
      # for i in 0..@numberOfPlayers-1 do
      #   if @players[i].to_s == ""
      #     lblMsg.text = "Introduce todos los nombres"
      #     lblMsg.textColor = Fox.FXRGB(205,  92,  92)
      #     isPlayersReady = false              
      #   end
      # end
      # if isPlayersReady 
      #   management.fillWords()
      #   management.fillBag()
      #   for i in 0..@numberOfPlayers-1 do
      #       management.createPlayer(@players[i].to_s)
      #   end
      #   firstPlayer = FirstPlayer.new(app, management)
      #   firstPlayer.create
      #   firstPlayer.show
      #   close(PLACEMENT_SCREEN)
      # else
      #   isPlayersReady = true
      # end
    end
   end
   def create
       super
       show(PLACEMENT_SCREEN)
   end
 end
