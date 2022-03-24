require './models/Bag.rb'
require './models/Player.rb'

class Management  
    $bag = []
    $players = []
    $gameTokensUsed = 0
    @originalBoard = []
    @board = []
    $words = []
    @word = ""

    def fillWords()
        content = File.read("./files/diccionario.txt")
        $words = content.split("\n")
    end

    def createBoard()
        @originalBoard = [["TP",0,0],["    ",0,1],["    ",0,2],["DL",0,3],["    ",0,4],["    ",0,5],["    ",0,6],["TP",0,7],["    ",0,8],["    ",0,9],["    ",0,10],["DL",0,11],["    ",0,12],["    ",0,13],["TP",0,14]],
        [["    ",1,0], ["DP",1,1],["    ",1,2], ["    ",1,3], ["    ",1,4], ["TL",1,5] ,["    ",1,6], ["    ",1,7], ["    ",1,8], ["TL",1,9], ["    ",1,10], ["    ",1,11], ["    ",1,12], ["DP",1,13], ["    ",1,14]],
        [["    ",2,0], ["    ",2,1], ["DP",2,2], ["    ",2,3], ["    ",2,4], ["    ",2,5], ["DL",2,6] ,["    ",2,7],["DL",2,8],["    ",2,9],["    ",2,10],["    ",2,11],["DP",2,12],["    ",2,13],["    ",2,14]],
        [["DL",3,0],["    ",3,1],["    ",3,2], ["DP",3,3], ["    ",3,4] , ["    ",3,5], ["    ",3,6], ["DL",3,7], ["    ",3,8], ["    ",3,9], ["    ",3,10], ["DP",3,11] ,["    ",3,12],["    ",3,13],["DL",3,14]],
        [["    ",4,0],["    ",4,1],["    ",4,2],["    ",4,3],["DP",4,4],["    ",4,5], ["    ",4,6], ["    ",4,7], ["    ",4,8], ["    ",4,9], ["DP",4,10], ["    ",4,11], ["    ",4,12], ["    ",4,13], ["    ",4,14]],
        [["    ",5,0], ["TL",5,1],["    ",5,2],["    ",5,3],["    ",5,4],["TL",5,5], ["    ",5,6], ["    ",5,7], ["    ",5,8], ["TL",5,9], ["    ",5,10], ["    ",5,11], ["    ",5,12], ["TL",5,13], ["    ",5,14]],
        [["    ",6,0], ["    ",6,1], ["DL",6,2], ["    ",6,3], ["    ",6,4], ["    ",6,5], ["DL",6,6], ["    ",6,7], ["DL",6,8], ["    ",6,9], ["    ",6,10], ["    ",6,11], ["DL",6,12], ["    ",6,13], ["    ",6,14]],
        [["TP",7,0],["    ",7,1],["    ",7,2], ["DL",7,3], ["    ",7,4], ["    ",7,5], ["    ",7,6], ["✴",7,7], ["    ",7,8], ["    ",7,9],["    ",7,10], ["DL",7,11], ["    ",7,12], ["    ",7,13], ["TP",7,14]],
        [["    ",8,0], ["    ",8,1], ["DL",8,2], ["    ",8,3], ["    ",8,4], ["    ",8,5], ["DL",8,6], ["    ",8,7], ["DL",8,8], ["    ",8,9], ["    ",8,10], ["    ",8,11], ["DL",8,12], ["    ",8,13], ["    ",8,14]],
        [["    ",9,0], ["TL",9,1], ["    ",9,2], ["    ",9,3], ["    ",9,4], ["TL",9,5], ["    ",9,6], ["    ",9,7], ["    ",9,8], ["TL",9,9], ["    ",9,10], ["    ",9,11], ["    ",9,12], ["TL",9,13], ["    ",9,14]],
        [["    ",10,0], ["    ",10,1], ["    ",10,2], ["    ",10,3], ["DP",10,4], ["    ",10,5], ["    ",10,6], ["    ",10,7], ["    ",10,8],["    ",10,9], ["DP",10,10], ["    ",10,11], ["    ",10,12], ["    ",10,13], ["    ",10,14]],
        [["DL",11,0],["    ",11,1],["    ",11,2], ["DP",11,3], ["    ",11,4], ["    ",11,5], ["    ",11,6], ["DL",11,7], ["    ",11,8], ["    ",11,9], ["    ",11,10], ["DP",11,11], ["    ",11,12], ["    ",11,13], ["DL",11,14]],
        [["    ",12,0], ["    ",12,1], ["DP",12,2], ["    ",12,3], ["    ",12,4], ["    ",12,5], ["DL",12,6], ["    ",12,7], ["DL",12,8],["    ",12,9],["    ",12,10],["    ",12,11], ["DP",12,12],["    ",12,13],["    ",12,14]],
        [["    ",13,0], ["DP",13,1], ["    ",13,2], ["    ",13,3], ["    ",13,4], ["TL",13,5], ["    ",13,6], ["    ",13,7], ["    ",13,8], ["TL",13,9], ["    ",13,10], ["    ",13,11], ["    ",13,12],  ["DP",13,13], ["    ",13,14]],
        [["TP",14,0], ["    ",14,1], ["    ",14,2], ["DL",14,3], ["    ",14,4], ["    ",14,5], ["    ",14,6], ["TP",14,7], ["    ",14,8],["    ",14,9], ["    ",14,10], ["DL",14,11], ["    ",14,12], ["    ",14,13], ["TP",14,14]]
        @board = Marshal.load(Marshal.dump(@originalBoard))
    end

    def changeValueBoard(i, j, token)
        @board[i][j][0] = token.symbol
        token.isUsed = true
        # @word = @word.to_s + token.symbol.to_s
    end

    def changeValueBoard_robot(i, j, letter)
        @board[i][j][0] = letter
        changeStateTokenByLetter(letter)
    end

    def changeStateTokenByLetter(letter)
        $bag.each do |token|
            if token.symbol == letter
                if token.isUsed == false
                    token.isUsed = true
                    token.available = false
                    puts "Available: #{getNumberAvailableTokens()}"
                    break;
                end
            end
        end
    end

    def undoBoard()
        @board = Marshal.load(Marshal.dump(@originalBoard))
        @word = ""
    end

    def updateOriginalBoard()
        @originalBoard = Marshal.load(Marshal.dump(@board))
        @word = ""
    end

    def getBoard()
        return @board
    end

    def showBoard()
        puts "\n"
        puts "\n"
        @originalBoard.each do |line|
            print "#{line}"
            print "\n"
        end
        puts "\n"
    end

    def getWord()
        return @word
    end

    def getWords(pos_initial, pos_final)
        # [0] => x , [1] => y
        puts "INICIAL: #{pos_initial}"
        x = pos_initial[0]
        y = pos_initial[1]
        wordInX = ""
        wordInY = ""

        # Volver al principio de la palabra horizontal
        lookingBeginningX = true
        while (lookingBeginningX and x > 0) do
            token = (@board[x][pos_initial[1]])[0]
            if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                lookingBeginningY = false
            end
            x = x - 1
        end
        puts x
        while (x < 15 or y < 15) do
            # puts "y: #{y}, x: #{x}"
            if(x <= 14)
                #Palabra Horizontal
                token = (@board[x][pos_initial[1]])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    x = 15
                else
                    # wordPerpendicular = wordPerpendicular(x, pos_initial[1], "vertical")
                    # puts "Perpendicular X: #{wordPerpendicular}"
                    wordInX = wordInX + token.to_s
                end
                x = x + 1
            end
            if(y <= 14)
                #Palabra Vertical
                token = (@board[pos_initial[0]][y])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    y = 15
                else
                    # wordPerpendicular = wordPerpendicular(pos_final[0], y, "horizontal")
                    # puts "Perpendicular Y: #{wordPerpendicular}"
                    wordInY = wordInY + token.to_s
                end
                y = y + 1
            end
        end
        puts "Word X: #{wordInX}"
        puts "Word Y: #{wordInY}"
        return [wordInX, wordInY]
        # if pos_initial[0] == -1 or pos_final[0] == -1
        #     return false
        # else
        #     if pos_initial[0] == pos_final[0]
        #         #Es una palabra horizontal
        #         for i in pos_initial[1]..pos_final[1] do
        #             token = (@board[pos_initial[0]][i])[0]
        #             if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
        #                 # @word = @word.to_s + " "
        #                 return ""
        #             else
        #                 @word = @word.to_s + token.to_s
        #             end
        #         end
        #     elsif pos_initial[1] == pos_final[1]
        #         #Es una palabra vertical
        #         for i in pos_initial[0]..pos_final[0] do
        #             token = (@board[i][pos_initial[1]])[0]
        #             if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
        #                 # @word = @word.to_s + " "
        #                 return ""
        #             else
        #                 @word = @word.to_s + token.to_s
        #             end
        #         end
        #     else
        #         return ""
        #     end
        #     return @word
        # end
    end

    def wordPerpendicular(x, y, direction)
        word = ""
        if (direction == "vertical")
            #X constante
            contY = y
            lookingStart = true
            while (lookingStart and contY >= 0) do
                token = (@board[x][contY])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    lookingStart = false
                end
                if (contY > 0)
                    contY = contY - 1
                end
            end
            while (contY < 15) do
                puts ("X: #{x}, Y: #{contY}")
                token = (@board[x][contY])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    contY = 15
                else
                    word = word.to_s + token
                    puts "Y: #{word}"
                end
                contY = contY + 1
            end
        elsif (direction == "horizontal")
            #Y constante
            contX = x
            lookingStart = true
            while (lookingStart and contX >= 0) do
                token = (@board[contX][y])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    lookingStart = false
                end
                if (contX > 0)
                    contX = contX - 1
                end
            end
            while (contX < 15) do
                puts ("X: #{contX}, Y: #{y}")
                token = (@board[contX][y])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    contX = 15
                else
                    word = word.to_s + token
                    puts "X: #{token}"
                end
                contX = contX + 1
            end
        else
        end
        return word
    end

    # def putWordInBoardNew(pos_letterInitial_word, pos_letterFinal_word, turn, score, player)
    def putWordInBoardNew(turn, player, letters, wordMultiplier)
        if letters.length == 0
            return ["Primero debes poner letras en el tablero","", 0]
        end
        score = 0
        surplusScoreTotal = 0
        word = ""
        letters.each do |letter|
            # puts letter[2]
            letterSurplusScore = letter[2]
            surplusScoreTotal = letterSurplusScore + surplusScoreTotal
        end
        i = letters[0][0]
        j = letters[0][1]
        orientation = getOrientationWord(i, j)
        if orientation == ""
            return ["La palabra debe unirse con otra letra del tablero","", 0]
        else
            if orientation == "horizontal"
                topJ = getTopPositionsHorizontal(i, j)
                word = getWordWithPosition(i, topJ, "horizontal")
                score = score + word[1]
            else
                topI = getTopPositionsVertical(i, j)
                word = getWordWithPosition(topI, j, "vertical")
                score = score + word[1]
            end
        end
        if word == ""
            return ["La palabra es incorrecta","", 0 ]
        elsif word.length < 2
            return ["La palabra (#{word[0]}) debe tener mínimo dos letras","", 0]
        else
            total = score+surplusScoreTotal
            if turn == 1
                if @board[7][7][0] == "✴"
                    return ["Pon una ficha en el centro","", 0]
                else
                    validWord = verifyWord(word[0])
                    if validWord
                        if wordMultiplier == "DP"
                            total = total * 2
                        elsif wordMultiplier == "TP"
                            total = total * 3
                        end
                        if (letters.length == 7)
                            total = total + 50
                            updateOriginalBoard()
                            # tot = changeScore(total, player, wordMultiplier)
                            return ["Scrabble!",word,total]
                        end
                        updateOriginalBoard()
                        # tot = changeScore(total, player, wordMultiplier)                            
                        # deleteSymbols(word[0], player)
                        return ["Palabra correcta", word, total]
                    else
                        return ["No encontramos la palabra '#{word[0]}' en nuestros diccionarios", "", 0]
                    end
                end
            else
                validWord = verifyWord(word[0])
                if validWord
                    if wordMultiplier == "DP"
                        total = total * 2
                    elsif wordMultiplier == "TP"
                        total = total * 3
                    end
                    if (letters.length == 7)
                        total = total + 50
                        updateOriginalBoard()
                        # tot = changeScore(total, player, wordMultiplier)                            
                        return ["Scrabble!",word,total]
                    end
                    updateOriginalBoard()
                    # tot = changeScore(total, player, wordMultiplier)                        
                    # deleteSymbols(word[0], player)
                    return ["Palabra correcta", word, total]
                else
                    return ["No encontramos la palabra '#{word[0]}' en nuestros diccionarios", "", 0]
                end
            end
        end
        return ["Error", "", 0]
    end

    def getOrientationWord(i, j)
        row = i
        col = j

        token = (@board[row][col-1])[0]
        if (token != "TP" and token != "DP" and token != "DL" and token != "TL" and token != "    " and token != "✴")
            return "horizontal"
        end
        if (col < 14)
            token = (@board[row][col+1])[0]
            if (token != "TP" and token != "DP" and token != "DL" and token != "TL" and token != "    " and token != "✴")
                return "horizontal"
            end
        end
        token = (@board[row-1][col])[0]
        if (token != "TP" and token != "DP" and token != "DL" and token != "TL" and token != "    " and token != "✴")
            return "vertical"
        end 
        if (row < 14)
            token = (@board[row+1][col])[0]
            if (token != "TP" and token != "DP" and token != "DL" and token != "TL" and token != "    " and token != "✴")
                return "vertical"
            end
        end

        if emptyBoard()
            return "Empty"
        end
        return ""
    end

    def emptyBoard()
        @board.each do |row|
            row.each do |token|
                isEmptyToken = isEmptyToken(token[0])
                if !isEmptyToken
                    return false
                end
            end
        end
        return true
    end

    def getWordWithPosition(i, j, direction)
        row = i
        col = j
        word = ""
        valueWord = 0
        if direction == "horizontal" 
            while (col < 15) do
                token = (@board[row][col])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    col = 15
                end
                if col < 15
                    value = getValueOfTokenBySymbol(token)
                    valueWord = valueWord + value
                    word = word.to_s + token.to_s
                    col = col + 1
                end
            end
        elsif direction == "vertical"
            while (row < 15) do
                token = (@board[row][col])[0]
                if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴"
                    row = 15
                end
                if (row < 15)
                    value = getValueOfTokenBySymbol(token)
                    valueWord = valueWord + value
                    word = word.to_s + token.to_s
                    row = row + 1
                end
            end
        else 
            puts "Error desconocido 101"
        end
        return [word, valueWord]
    end

    def getValueOfTokenBySymbol(symbol)
        for i in 0..$bag.length-1 do
            if $bag[i].symbol == symbol
                return $bag[i].value
            end
        end
    end

    def getTopPositionsHorizontal(i, j)
        # Volver al principio de la palabra horizontal
        row = i
        column = j - 1
        while (column >= 0) do
            token = (@board[row][column])[0]
            if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴" || column == 0
                return column + 1
            end
            column = column - 1
        end
        return j
    end
    def getTopPositionsVertical(i, j)
        # Volver al principio de la palabra vertical
        row = i - 1
        column = j
        while (row >= 0) do
            token = (@board[row][column])[0]
            if token == "TP" || token == "DP" || token == "DL" || token == "TL" || token == "    " || token == "✴" || row == 0
                return row + 1
            end
            row = row - 1
        end
        return i
    end

    def fillBag()
        bag = Bag.new()
        $bag = bag.getTokens()
    end

    def randomGameToken()
        random = rand(0..$bag.length-1)
        return random
    end

    def getSymbolByIndex(index)
        return $bag[index].symbol
    end

    def getGameTokens(quantity)
        gameTokens = []
        if $gameTokensUsed != 100
            for i in 1..quantity do
                gameToken = getOneGameToken()
                gameTokens << gameToken
            end
        end
        return gameTokens
    end

    def getOneGameToken()
        gameToken = $bag[0]
        random = -1
        loop do
            random = randomGameToken()
            gameToken = $bag[random]
            break if gameToken.available and gameToken.isUsed == false
        end
        $bag[random].available = false
        $gameTokensUsed = $gameTokensUsed + 1
        return gameToken
    end

    def showGameTokens(player)
        return $players[player].deckOfgameTokens
    end
   
    def createPlayer (name, isBot)
        player = Player.new(name, getGameTokens(7), 0,randomGameToken(), isBot)
        $players << player
        #orderPlayers(player)
    end

    def getFirstPlayer()
        players = $players
        firstPlayer = players[0]
        player = 0
        for i in 0..players.length-1 do
            if players[i].firstToken <= firstPlayer.firstToken
                firstPlayer = players[i]
                player = i
            end
        end
        return player
    end

    def getPlayers()
        return $players
    end

    def validateSymbolsOfWord(word, playerGameTokens)
        cont = 0
        if word.length > 1
            for i in 0..word.length-1 do
                verify = false
                playerGameTokens.each do |token|
                    if word[i] == token.symbol
                        cont = cont + token.value
                        verify = true
                        break
                    end
                end
                if verify == false
                    break;
                end
            end
            if cont != 0
                verifyWord = verifyWord(word)
                if verifyWord == false
                    cont = 0
                end
            end
        end
        return cont
    end

    def verifyWord(word)
        words = $words
        for i in 0..words.length-1 do
            if word == words[i]
                return true
            end
        end
        return false
    end

    def changeScore(value, player, wordMultiplier)
        if wordMultiplier == "DP"
            value = value * 2
        elsif wordMultiplier == "TP"
            value = value * 3
        else
        end
        $players[player].score = $players[player].score + value
        return value
    end

    def changeDeckOfPlayer_newMethod(player)
        $players[player].deckOfgameTokens = getGameTokens(7)
    end

    def changeDeckOfPlayer(player)
        $players[player].deckOfgameTokens = getGameTokens(7)
        return true
    end

    def putWordInBoard(row, column, word, valueWord, turn, orientation)
        maxPosition = -1
        if orientation == "V"
            maxPosition = row + (word.length-1)
        else
            maxPosition = column + (word.length-1)
        end
        if maxPosition <= 15
            if turn == 1
                verifyFirstTurn = false
                if orientation == "H"
                    verifyFirstTurn = false
                    for i in column..maxPosition do
                        if row == 7 and i == 7
                            verifyFirstTurn = true
                            break
                        end
                    end
                    if verifyFirstTurn
                        for i in 0..word.length-1 do
                            value = verifyScoreOfWord(row,column+i, word[i], valueWord)
                            valueWord = value
                            @originalBoard[row][column+i] = word[i]
                        end
                        return valueWord
                    else
                        return -1
                    end
                elsif orientation == "V"
                    verifyFirstTurn = false
                    for i in row..maxPosition do
                        if i == 7 and column == 7
                            verifyFirstTurn = true
                            break
                        end
                    end
                    if verifyFirstTurn
                        for i in 0..word.length-1 do
                            value = verifyScoreOfWord(row+i,column, word[i], valueWord)
                            valueWord = value
                            @originalBoard[row+i][column] = word[i]
                        end
                        return valueWord
                    else
                        return -1
                    end
                end
            else
                if orientation == "H"
                    verifyWord = true
                    for i in 0..word.length-1 do
                        value = verifyScoreOfWord(row,column+i, word[i], valueWord)
                        valueWord = value
                        if (value == -3)
                            verifyWord = false
                            break
                        end
                    end
                    if verifyWord
                        for i in 0..word.length-1 do
                            value = verifyScoreOfWord(row,column+i, word[i], valueWord)
                            valueWord = value
                            @originalBoard[row][column+i] = word[i]
                        end
                    end
                    return valueWord
                elsif orientation == "V"
                    verifyWord = true
                    for i in 0..word.length-1 do
                        value = verifyScoreOfWord(row+i,column, word[i], valueWord)
                        valueWord = value
                        if (valueWord == -3)
                            verifyWord = false
                            break
                        end
                    end
                    if verifyWord
                        for i in 0..word.length-1 do
                            value = verifyScoreOfWord(row+i,column, word[i], valueWord)
                            valueWord = value
                            @originalBoard[row+i][column] = word[i]
                        end
                    end
                    return valueWord
                end
            end
        else
            return -2
        end
    end

    def verifyScoreOfWord(row, column, symbol, valueWord)
        if @originalBoard[row][column] == "TP"
            valueWord = valueWord * 3
        elsif @originalBoard[row][column] == "DP"
            valueWord = valueWord * 2
        elsif @originalBoard[row][column] == "TL"
            valueSymbol = searchValueOfSymbol(symbol)
            if valueSymbol != -1 
                valueWord = valueWord - valueSymbol + (valueSymbol*3)
            end
        elsif @originalBoard[row][column] == "DL"
            valueSymbol = searchValueOfSymbol(symbol)
            if valueSymbol != -1
                valueWord = valueWord - valueSymbol + (valueSymbol*2)
            end
        elsif @originalBoard[row][column] == "    "
        elsif @originalBoard[row][column] == "✴"

        elsif @originalBoard[row][column] != symbol
            valueWord = -3
        end
        return valueWord
    end

    def searchValueOfSymbol(symbol)
        for i in 0..$bag.length-1 do
            if $bag[i].symbol == symbol
                return $bag[i].value
            end
        end
        return -1
    end

    def searchSymbolAvailableBySymbol(symbol)
        for i in 0..$bag.length-1 do
            if $bag[i].symbol == symbol
                if $bag[i].available
                    puts $bag[i].symbol
                    return $bag[i]
                end
            end
        end
    end

    def deleteSymbols(word, player)
        newTokens = getGameTokens(word.length)
        tokens = $players[player].deckOfgameTokens
        for i in 0..word.length-1 do
            for j in 0..tokens.length-1 do
                if tokens[j].symbol == word[i]
                    tokens[j].available = false
                    tokens[j].isUsed = true
                    tokens.delete_at(j)
                    tokens << newTokens[i]
                    break;
                end
            end
        end
    end

    def getNumberAvailableTokens()
        cont = 0
        for i in 0..$bag.length-1 do
            if $bag[i].available
                cont = cont + 1
            end
        end
        return cont
    end

    def getWinners()
        auxScore = 0
        winners = []
        for i in 0..$players.length-1 do
            if auxScore < $players[i].score
                winners.clear()
                winners << $players[i]
                auxScore = $players[i].score
            elsif auxScore == $players[i].score
                winners << $players[i]
                auxScore = $players[i].score
            end
        end
        return winners
    end

    def generateWords(atril)
        possibleWords = []
        word = ""
        atril.each do |token| 
            word = word + token.symbol.to_s
        end
        possibleWords << word

        letters = word.length
        while (letters > 1) do
            for i in 0..letters-1 do
                letterOriginal = word[i]
                for j in 0..letters-2 do
                    newWord = Marshal.load(Marshal.dump(word))
                    newWord[i] = newWord[j+1]
                    newWord[j+1] = letterOriginal
                    if newWord != word and !existPossibleWord(newWord, possibleWords)
                        possibleWords << newWord
                    end
                end
            end
            letters = letters - 1
        end
        i = word.length - 1
        inverseWord = ""
        while (i >= 0)
            letterOriginal = word[i]
            inverseWord = inverseWord + word[i]
            i = i - 1
        end
        possibleWords << inverseWord
        letters = inverseWord.length
        while letters > 1 do
            for i in 0..letters-1 do
                letterOriginal = inverseWord[i]
                for j in 0..letters-2 do
                    newWord = Marshal.load(Marshal.dump(inverseWord))
                    newWord[i] = newWord[j+1]
                    newWord[j+1] = letterOriginal
                    if newWord != inverseWord and !existPossibleWord(newWord, possibleWords)
                        possibleWords << newWord
                    end
                end
            end
            letters = letters - 1
        end
        return getSubStringsOfPossibleWords(possibleWords)
    end

    def getSubStringsOfPossibleWords(possibleWords)
        numberOfWords = 0
        newPossibleWords = []
        numberOfLetters = 7
        while numberOfLetters > 1 do
            possibleWords.each do |possibleWord|
                $words.each do |word|
                    if word.length == numberOfLetters
                        if possibleWord.include? word and !existPossibleWord(word, possibleWords)
                            newPossibleWords << [word, valueOfWord(word)]
                        end
                    end
                end
            end
            numberOfLetters = numberOfLetters - 1
        end
        return newPossibleWords
    end

    def valueOfWord(word)
        total = 0
        for i in 0..word.length-1 do
            total = total + getValueOfTokenBySymbol(word[i])
        end
        # puts "#{word}: #{total}"
        return total
    end

    def existPossibleWord(newWord, words)
        words.each do |word|
            if word == newWord
                return true
            end
        end
        return false
    end

    def fullBoard()
        @originalBoard.each do |row|
            row.each do |token|
                symbol = token[0]
                if symbol == "TP" || symbol == "DP" || symbol == "DL" || symbol == "TL" || symbol == "    " || symbol == "✴"
                    return false
                end
            end
        end
        return true
    end

    @super_move = []
    @contt = 0
    @finish = false
    def searchAlgorithm(node, player, bot, movements, depth , a, b)
        best_move = node
        best_score = bot ? 1000 : -1000
        winners = getWinners()
        if (winners.length == 1 || fullBoard() || @finish || depth == movements.length)
            return [best_score, movements[0]]
        end
        
        #Movimientos permitidos
        # movements = getPossibleMovements(atril, turn, player)
        # puts "MOVES: #{movements.length}"
        for i in 0..movements.length-1 do
            move = movements[i]

            # paintWordInBoard(move)
            # [row, col, direction, word, resp[2]]

            if (bot)
                resp = searchAlgorithm(move, player,false, movements,depth+1, a,b)
                score = resp[0]
                move = resp[1]
                if best_score < score
                    score = score - depth * 10
                    best_move = move

                    values = [a, best_score]
                    a = values.max
                    break if b <= a
                end     
                # puts "Bot: #{move}"                   
                
            else
                    move = movements[i]
                    resp = searchAlgorithm(move, player, true, movements,depth+1, a,b)
                    score = resp[0]
                    move = resp[1]

                    if best_score > score
                        best_score = score + depth * 10
                        best_move = move

                        values = [b, best_score]
                        b = values.min
                    end
                    break if b <= a
            end
        
            # undoBoard()
            return [best_score, best_move]
        end
    end


    def paintWordInBoard(move)
        row = move[0]
        col = move[1]
        direction = move[2]
        word = move[3]
        for i in 0..word.length-1 do
            if direction[0] == "V"
                changeValueBoard_robot(row+i, col, word[i])
            elsif direction[0] == "H"
                changeValueBoard_robot(row, col+i, word[i])
            else
                puts "Error direcciones"
                puts direction
            end
        end
    end

    # def valorMax (g, a, b)

    # end

    # def valorMin (g, a, b)
    # end

    def getPossibleMovements(atril, turn, player)
        words = generateWords(atril)
        movements = []
        words.each do |palabra|
            word = palabra[0]
            for i in 0..word.length-1 do
                # puts "Letra: #{word[i]}"
                tokens = getEqualsTokensInBoard(word[i])
                if tokens.length > 0
                    tokens.each do |token|
                        row = token[1]
                        col = token[2]                        
                        direction = canPutWordInPosition(row, col, word)
                        if direction[0] != "No"
                            pressedLetters = direction[1]
                            wordMultiplier = direction[2]
                            resp = putWordInBoardNew(turn, player, pressedLetters, wordMultiplier)
                            if (resp[0] == "Palabra correcta" || resp[0] == "Scrabble!")
                                total = resp[2]
                                movements << [row, col, direction, word, total]
                            elsif (resp[0] == "Pon una ficha en el centro")                                
                                total = resp[2]                                
                                movements << [row, col, direction, word, total]
                            end
                        end
                        # break if foundWord
                    end
                else
                    direction = canPutWordInPosition(7, 6, word)
                    if direction[0] != "No"
                        pressedLetters = direction[1]
                        wordMultiplier = direction[2]                        
                        resp = putWordInBoardNew(turn, player, pressedLetters, wordMultiplier)
                        puts resp[0]
                        if (resp[0] == "Pon una ficha en el centro")                                
                            total = resp[2]                         
                            movements << [7, 5, direction, word, total]
                        end
                    end
                end
                # break if movements.length > 0
            end
            # break if foundWord
        end
        return movements
    end

    def getEqualsTokensInBoard(letter)
        tokens = []
        @board.each do |row|
            row.each do |token|
                # puts "Token: #{token[0]}, letter: #{letter}"
                if token[0] == letter
                    tokens << token
                end
            end
        end
        return tokens
    end

    def canPutWordInPosition(i, j, word)
        #Get position of letter in word equal to the position in the board
        pressedLetters = []
        symbol = @board[i][j]
        pos = 0
        for f in 0..word.length-1 do
            if symbol[0] == word[f]
                pos = f
                break;
            end
        end

        wordMultiplier = ""

        #Put Horizontal word
        col = j - pos
        numberOfLetters = 0
        while col > 0 and col < 15 do
            if col != j
                token = @board[i][col]
                if isEmptyToken(token[0])
                    col = col + 1
                    letter = word[numberOfLetters]
                    numberOfLetters = numberOfLetters + 1
                    if (letter != word[j])
                        valueOfLetter = getValueOfTokenBySymbol(letter)
                        if token[0] == "DL"
                            valueOfLetter = valueOfLetter * 2
                        elsif token[0] == "TL"
                            valueOfLetter = valueOfLetter * 3
                        elsif token[0] == "✴"
                            valueOfLetter = valueOfLetter * 5
                        elsif token[0] == "DP" || token[0] == "TP"
                            wordMultiplier = token[0]
                        end
                        #Es col-1 porque se quita la letra que ya está
                        pressedLetters << [i, col-1, valueOfLetter]
                    end
                    break if numberOfLetters == word.length
                else
                    col = -1
                    break;
                end
            else
                col = col + 1
            end
            break if col == -1;
        end
        if col != -1
            return ["H", pressedLetters, wordMultiplier]
        end


        #Put Vertical word
        wordMultiplier = ""
        pressedLetters.clear()
        numberOfLetters = 0
        row = i - pos
        while row > 0 and row < 15 do
            if row != i
                token = @board[row][j]
                if isEmptyToken(token[0])
                    row = row + 1
                    letter = word[numberOfLetters]
                    numberOfLetters = numberOfLetters + 1
                    if (letter != word[i])
                        valueOfLetter = getValueOfTokenBySymbol(letter)
                        if token[0] == "DL"
                            valueOfLetter = valueOfLetter * 2
                        elsif token[0] == "TL"
                            valueOfLetter = valueOfLetter * 3
                        elsif token[0] == "✴"
                            valueOfLetter = valueOfLetter * 5
                        elsif token[0] == "DP" || token[0] == "TP"
                            wordMultiplier = token[0]
                        end
                        #Es row-1 debido a que se elimina la letra que ya existe
                        pressedLetters << [row-1, j, valueOfLetter]
                    end
                    break if numberOfLetters == word.length
                else
                    row = -1
                end
            else
                row = row + 1
            end
            break if row == -1;
        end
        if row != -1
            return ["V",pressedLetters, wordMultiplier]
        end
        return ["No", [], wordMultiplier]
    end

    def isEmptyToken(symbol)
        if symbol == "TP" || symbol == "DP" || symbol == "DL" || symbol == "TL" || symbol == "    " || symbol == "✴"
            return true
        end
        return false
    end

    def numberOfEmptyAndConsecutiveTokens_InRow(row)
        col = 0
        numberOfTokensEmpty = 0
        while (col<=14) do
            token = @board[row][col]
            if isEmptyToken(token[0])
                numberOfTokensEmpty = numberOfTokensEmpty + 1
            else
                numberOfTokensEmpty = 0
            end
            col = col + 1
        end
        return numberOfTokensEmpty
    end

    def numberOfEmptyAndConsecutiveTokens_InCol(col)
        row = 0
        numberOfTokensEmpty = 0
        while (row<=14)
            token = @board[row][col]
            if isEmptyToken(token[0])
                numberOfTokensEmpty = numberOfTokensEmpty + 1
            else
                numberOfTokensEmpty = 0
            end
            row = row + 1
        end
        return numberOfTokensEmpty
    end
end  

