require './views/Lectern.rb'

require 'fox16'
include Fox



class Board < FXMainWindow
    # def initialize(app, management, firstPlayer, turn, score, contOfTokens, letterInitial_pos, letterFinal_pos)
    def initialize(app, management, firstPlayer, turn, pressedLetters, multiplierWord, contTurnPass)
        super(app, "Scrabble", :width=> 1000, :height => 600)
        @management = management
        @players = @management.getPlayers()
        @board = @management.getBoard()
        @word = @management.getWord()
        btnsOfBoard = []
        @turn = turn
        @index = firstPlayer
        @atril = @management.showGameTokens(@index)
        @father = app
        @multiplierWord = multiplierWord
        @multiplierLetter = ""
        @pressedLetters = pressedLetters
        @contTurnPass = contTurnPass

        frameWindow = FXHorizontalFrame.new(self, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|PACK_UNIFORM_HEIGHT)
        
        frameV_board = FXVerticalFrame.new(frameWindow, FRAME_SUNKEN|LAYOUT_CENTER_X|LAYOUT_CENTER_Y)
        @board.each do |row|
            frame_row_board = FXHorizontalFrame.new(frameV_board, FRAME_LINE|PACK_UNIFORM_WIDTH)
            row.each do |token|
                btnToken = FXButton.new(frame_row_board, token[0], nil,nil, 0,FRAME_THICK|LAYOUT_FIX_WIDTH,0, 0, 30, 20)
                btnToken.connect(SEL_COMMAND) do
                    if token[0] == "TP" or token[0] == "DP"
                        @multiplierWord = token[0].to_s
                    end
                    if token[0] == "DL" or token[0] == "TL" or token[0] == "✴"
                        @scoreLetter = token[0].to_s
                    else 
                        @scoreLetter = 0
                    end
                    lectern = Lectern.new(app, @atril, method(:onPressedToken),method(:giveBackTokens), method(:changeTokens),token[0], token[1], token[2])
                    lectern.create
                    lectern.show
                end
                if token[0] == "TP"
                    btnToken.backColor = Fox.FXRGB(238,  99,  99)
                elsif token[0] == "DL"
                    btnToken.backColor = Fox.FXRGB(0, 255, 255)
                elsif token[0] == "TL"
                    btnToken.backColor = Fox.FXRGB(0  , 139, 139)
                elsif token[0] == "DP"
                    btnToken.backColor = Fox.FXRGB(255, 200, 0)
                elsif token[0] == "✴"
                    btnToken.backColor = Fox.FXRGB(255, 255, 0)
                elsif token[0] == "    "
                    btnToken.backColor = Fox.FXRGB(211, 211, 211)
                else
                    btnToken.backColor = Fox.FXRGB(210,105,30)
                    btnToken.frameStyle = FRAME_RAISED
                    btnToken.connect(SEL_COMMAND) do
                    end
                end
            end
        end
        FXVerticalSeparator.new(frameWindow,LAYOUT_FILL_Y|SEPARATOR_GROOVE|LAYOUT_SIDE_RIGHT)

        frameV_infoBoard = FXVerticalFrame.new(frameWindow, LAYOUT_RIGHT|LAYOUT_CENTER_Y|FRAME_RAISED)
        
        frameH_LblMsg = FXHorizontalFrame.new(frameV_infoBoard, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
        lblMsgScore = FXLabel.new(frameH_LblMsg, "Puntaje")
        lblMsgScore.textColor = Fox.FXRGB(255,  69,   0)
        fontScore = FXFont.new(app, "score", 12)
        lblMsgScore.font = fontScore
        for i in 0..@players.length-1 do
            FXLabel.new(frameV_infoBoard, "#{@players[i].name}: #{@players[i].score}")
        end

        frameH_LblTurn = FXHorizontalFrame.new(frameV_infoBoard, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
        @lblTurn = FXLabel.new(frameH_LblTurn, "Turno #{@turn} de #{@players[@index].name}")
        @lblTurn.textColor = Fox.FXRGB( 32, 178, 170)
        fontTurn = FXFont.new(app, "turn", 12)
        @lblTurn.font = fontTurn

        frameH_LblTokens = FXHorizontalFrame.new(frameV_infoBoard, LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH)
        
        lblTokens = FXLabel.new(frameH_LblTokens, "Presiona una casilla del tablero para revisar tu atril")
        lblTokens.textColor = Fox.FXRGB(210,105,30)
        fontTokens = FXFont.new(app, "tokens", 12)
        lblTokens.font = fontTokens

        # @lblWord = FXLabel.new(frameV_infoBoard, "Tu palabra es: #{@word}")
        # fontWord = FXFont.new(app, "word", 15)
        # @lblWord.font = fontWord

        frameV_buttons = FXVerticalFrame.new(frameV_infoBoard, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH|FRAME_GROOVE)
        btnSend = FXButton.new(frameV_buttons, "Enviar palabra")
        btnSend.backColor = Fox.FXRGB(210,105,30)
        btnSend.connect(SEL_COMMAND) do
            response = @management.putWordInBoardNew(@turn, @index, @pressedLetters, @multiplierWord)
            if response[0] == "Palabra correcta" || response[0] == "Scrabble!"
                q = FXMessageBox.information(app, MBOX_OK, "Bien", response[0])
                if q == MBOX_CLICKED_OK
                    word = response[1][0]
                    total = response[2]
                    @management.deleteSymbols(word, @index)
                    @management.changeScore(total, @index, "")  
                    @contTurnPass = 0
                    nextPlayer()
                end
            else
                q = FXMessageBox.error(app, MBOX_OK, "Error", response[0])
                if q == MBOX_CLICKED_OK
                    giveBackTokens()
                end
            end
        end

        btnGiveBack = FXButton.new(frameV_buttons,"Devolver fichas")
        btnGiveBack.backColor = Fox.FXRGB(255, 200, 0)
        btnGiveBack.connect(SEL_COMMAND) do
            giveBackTokens()
        end

        btnNext = FXButton.new(frameV_buttons, "Pasar turno")
        btnNext.connect(SEL_COMMAND) do
            q = FXMessageBox.warning(app, MBOX_YES_NO, "Pasar turno", "¿Deseas pasar tu turno?")
            if q == MBOX_CLICKED_YES
                @contTurnPass = @contTurnPass + 1
                nextPlayer()
            end
        end
        btnNext.backColor = Fox.FXRGB( 32, 178, 170)

        frameBtnRobot = FXHorizontalFrame.new(frameV_infoBoard, LAYOUT_CENTER_Y|LAYOUT_CENTER_X|PACK_UNIFORM_WIDTH|FRAME_GROOVE)
        btnRobot = FXButton.new(frameBtnRobot, "Activar robot")
        btnRobot.backColor = Fox.FXRGB(255, 0, 0)
        btnRobot.buttonStyle = @players[@index].isRobot ? BUTTON_NORMAL : BUTTON_AUTOHIDE
        btnRobot.connect(SEL_COMMAND) do
            if @players[@index].isRobot
                # mar = "MAR"
                # @management.paintWordInBoard([7,7,"H","MAR"])
                # @management.updateOriginalBoard()
                numberTokenAvailable = @management.getNumberAvailableTokens()

                if (numberTokenAvailable > 7)
                    movements = @management.getPossibleMovements(@atril, @turn, @index)
                    if movements.length > 0
                #         # resp = @management.searchAlgorithm([], @index, @players[@index].isRobot, movements, 0 , -1000, 1000)
                #         # puts resp
                        @management.paintWordInBoard(movements[0])
                        @management.updateOriginalBoard()
                        move = movements[0]
                        word = move[3]
                        total = move[4]
                        @management.deleteSymbols(word, @index)
                        @management.changeScore(total, @index, "")                     
                    else
                        q = FXMessageBox.information(app, MBOX_OK, "Siguiente jugador", "Cambio de fichas")
                        if q == MBOX_CLICKED_OK
                            @management.changeDeckOfPlayer_newMethod(@index)
                            @atril = @management.showGameTokens(@index)
                        end
                    end
                else
                    q = FXMessageBox.information(app, MBOX_OK, "Siguiente jugador", "Pasé turno")
                    if q == MBOX_CLICKED_OK
                        @contTurnPass = @contTurnPass + 1
                    end
                end
                nextPlayer()
            end
        end

        def onPressedToken(token, i, j, scoreLetter)
            @management.changeValueBoard(i, j, token)
            @pressedLetters << [i, j, scoreLetter]
            # @contOfTokens = @contOfTokens + 1
            # board = Board.new(app, @management, @index, @turn, @score, @contOfTokens, @position_letterInitial_word, @position_letterFinal_word)
            
            board = Board.new(app, @management, @index, @turn, @pressedLetters, @multiplierWord, @contTurnPass)
            board.create
            board.show
            close(PLACEMENT_SCREEN)
        end

        def giveBackTokens()
            @atril.each do |token|
                token.isUsed = false 
            end
            @management.undoBoard()
            @pressedLetters.clear
            #Creo que @score debería ser 0
            # board = Board.new(app, @management, @index, @turn, @score, 0, [-1, -1], [-1, -1])
            board = Board.new(app, @management, @index, @turn, @pressedLetters, @multiplierWord, @contTurnPass)
            board.create
            board.show
            close()
        end

        def changeTokens()
            q = FXMessageBox.warning(app, MBOX_YES_NO, "Cambiar fichas", "¿Deseas cambiar tus fichas?")
            if q == MBOX_CLICKED_YES
                @management.changeDeckOfPlayer_newMethod(@index)
                @atril = @management.showGameTokens(@index)
                nextPlayer()
            end
        end

        def nextPlayer()
            if @contTurnPass >= 4
                winners = @management.getWinners()
                if winners.length > 1
                    msg = "Empate entre:\n"
                    winners.each do |winner|
                        msg = msg + "#{winner.name}\n"
                    end
                    q = FXMessageBox.information(app, MBOX_OK, "Partida finalizada", msg)
                    if q == MBOX_CLICKED_OK
                        @contTurnPass = 4
                    end
                else
                    q = FXMessageBox.information(app, MBOX_OK, "Partida finalizada", "El ganador es #{winners[0].name} con #{winners[0].score} puntos")
                    if q == MBOX_CLICKED_OK
                        @contTurnPass = 4
                    end
                end
                board = Board.new(app, @management, @index, @turn, @pressedLetters, @multiplierWord, @contTurnPass)
                board.create
                board.show
                close(PLACEMENT_SCREEN)
            else
                @index =  @index - 1
                @atril = @management.showGameTokens(@index)
                if  @index < 0
                    @index = @players.length-1
                    @turn = @turn + 1
                end
                @lblTurn.text = "Turno #{@turn} de #{@players[@index].name}"
                @word = ""
                # @lblWord.text = "Tu palabra es: #{@word}"
                # @score = 0
                # @contOfTokens = 0
                @multiplierWord = ""
                giveBackTokens()
                # moveBot()
            end
        end
    end
    def create
        super
        show(PLACEMENT_SCREEN)
    end    
end
