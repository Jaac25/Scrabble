require 'fox16'
include Fox

class Lectern < FXMainWindow
   def initialize(app, atril, onPressedToken, giveBackTokens, changeTokens,symbolBoard, i, j)
        @onPressed = onPressedToken
        @giveBackTokens = giveBackTokens
        @changeTokens = changeTokens
        super(app, "Elige una ficha", :width=> 300, :height => 150)
        frameLecternV = FXVerticalFrame.new(self, LAYOUT_CENTER_X|LAYOUT_CENTER_Y|PACK_UNIFORM_HEIGHT)
        frameLecternH = FXHorizontalFrame.new(frameLecternV, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
        atril.each do |token|
            btnToken = FXButton.new(frameLecternH, token.symbol, nil,nil, 0,LAYOUT_FIX_WIDTH,0, 0, 30, 20)
            btnToken.connect(SEL_COMMAND) do
                scoreLetter = token.value
                if symbolBoard == "DL"
                    #Se resta el scoreLetter para dejar solo el excedente, porque después se suma cada letra
                    scoreLetter = (scoreLetter * 2) - scoreLetter
                elsif symbolBoard == "TL"
                    scoreLetter = (scoreLetter * 3) - scoreLetter
                elsif symbolBoard == "✴"
                    scoreLetter = (scoreLetter * 5) - scoreLetter
                else
                    scoreLetter = 0
                end
                @onPressed.call(token, i, j, scoreLetter)
                close()
            end
            if token.isUsed                
                btnToken.buttonStyle = BUTTON_AUTOGRAY
            else
                btnToken.buttonStyle = BUTTON_TOOLBAR
                btnToken.backColor = Fox.FXRGB(210,105,30)
                btnToken.frameStyle = FRAME_RIDGE
            end
        end
        frameButtons_H = FXHorizontalFrame.new(frameLecternV, LAYOUT_CENTER_X)
        btnGiveBack = FXButton.new(frameButtons_H,"Devolver fichas")
        btnGiveBack.backColor = Fox.FXRGB(255, 200, 0)
        btnGiveBack.connect(SEL_COMMAND) do
            @giveBackTokens.call()
            close()
        end
        btnCambiar = FXButton.new(frameButtons_H, "Cambiar fichas")
        btnCambiar.backColor = Fox.FXRGB(0, 255, 0)
        btnCambiar.connect(SEL_COMMAND) do
            @changeTokens.call()
            close()
        end
   end
   def create
       super
       show(PLACEMENT_SCREEN)
   end
 end
