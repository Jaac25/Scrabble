require './views/Window_Players.rb'

require 'fox16'
include Fox

class WindowMode < FXMainWindow
    def initialize(app, management)
        super(app,"Scrabble",:width=> 300, :height => 200,:opts=> DECOR_ALL)
        vFrame = FXVerticalFrame.new(self, LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
        lblMsg = FXLabel.new(vFrame, "Elige tu modo de juego")
        lblMsg.textColor = Fox.FXRGB(  0, 104, 139)
        fontMsg = FXFont.new(app, "msg", 15)
        lblMsg.font = fontMsg
        hButtons = FXHorizontalFrame.new(vFrame, LAYOUT_CENTER_X|LAYOUT_CENTER_Y|FRAME_RAISED)
        btnMode1 = FXButton.new(hButtons, "Normal")
        btnMode1.backColor = Fox.FXRGB(192, 255,  62)
        btnMode1.connect(SEL_COMMAND) do
            windowPlayers = WindowPlayers.new(app, management)
            windowPlayers.create
            windowPlayers.show
            close()
        end
        btnMode2 = FXButton.new(hButtons, "En línea")
        btnMode2.backColor = Fox.FXRGB(151, 255, 255)
        btnMode2.connect(SEL_COMMAND) do
            # windowPlayers = WindowPlayers.new(app, management)
            # windowPlayers.create
            # windowPlayers.show
            # close()
        end
#         app = FXApp.new
# windowPlayers = WindowPlayers.new(app, management)
# app.create
# app.run
    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end
 end