require './management/Management.rb'
require './views/Window_Mode.rb'
require 'fox16'
include Fox

playing = true

management = Management.new()

turn = 1;
orderedPlayers = []
puts "¿Cuántos jugarán (mínimo 2, máximo 4)?"
app = FXApp.new
indexWindow = WindowMode.new(app, management)
app.create
app.run
# getApp().exit(0)

quantityPlayers = gets.to_i
if quantityPlayers >= 2 and quantityPlayers <= 4

    management.fillWords()
    management.createBoard()
    management.fillBag()

    for i in 1..quantityPlayers do
        puts "Nombre del jugador #{i}, por favor"
        name = gets.chomp
        management.createPlayer(name)
    end

    firstPlayer = management.getFirstPlayer()
    players = management.getPlayers()
    puts "\n============================================================================================================"
    puts "Comienza el jugador #{players[firstPlayer].name} por la ficha |#{management.getSymbolByIndex(players[firstPlayer].firstToken)}|"
    puts "============================================================================================================"
    puts "\n\n"
    index = firstPlayer
    while(playing) do
        
        # app = FXApp.new
        # Principal.new(app)
        # app.create
        # app.run

        opc = 0
        loop do
            puts "Jugador #{players[index].name} elige una opción: "
            puts "-----------------------------"
            puts "| 1. Ver tablero             |"
            puts "| 2. Mirar atril y lanzar    |"
            puts "| 3. Pasar                   |"
            puts "-----------------------------"
            opc = gets.to_i
            break if opc == 1 or opc == 2 or opc == 3
        end
        puts "\n"
        if opc == 1
            management.showBoard()
            index = index + 1
        elsif opc == 2
            management.showBoard()
            playerGameTokens = management.showGameTokens(index)
            puts "Atril del jugador #{players[index].name}:"
            puts "_________________________________________________________\n\n"
            for i in 0..playerGameTokens.length-1 do
                print " (#{playerGameTokens[i].symbol}, #{playerGameTokens[i].value}) "
            end
            puts "\n_________________________________________________________"
            puts "\n"
                  
            valueWord = 0
            word = ""
            loop do
                print "Introduce tu palabra, #{players[index].name}: "
                word = gets.chomp
                word = word.upcase


                puts "\n"
                valueWord = management.validateSymbolsOfWord(word, playerGameTokens)
                if valueWord == 0
                    puts "\n Palabra Incorrecta"
                    puts "\n"
                    opcTwo = 0
                    loop do
                        puts "Elige una opción, #{players[index].name}:"
                        puts "-----------------------------"
                        puts "| 1. Intentar nuevamente     |"
                        puts "| 2. Cambiar letras          |"
                        puts "-----------------------------"
                        opcTwo = gets.to_i
                        if opcTwo == 2
                            verifyChangeDeck = management.changeDeckOfPlayer(index)
                            if verifyChangeDeck
                                puts "\n"
                                puts "Atril del jugador #{players[index].name} cambiado"
                                puts "\n"
                                valueWord = -1
                            end
                        end
                        break if opcTwo == 1 or opcTwo == 2
                    end
                end
                break if valueWord != 0
            end
            if valueWord > 0
                loop do
                    puts "--------------------------------------------------------------------------------------"
                    puts "Escribe la fila y la columna en la que quieres poner la primer letra de tu palabra:"
                    row = 0
                    column = 0
                    orientation = ""
                    loop do 
                        print "Fila: "
                        row = gets.to_i
                        break if row > 0 and row < 16
                    end
                    loop do 
                        print "Columna: "
                        column = gets.to_i
                        break if column > 0 and column < 16
                    end
                    puts "Escribe la orientación: Horizontal (H) o Vertical (V): "
                    loop do 
                        print "Orientación (H - V): "
                        orientation = gets.chomp
                        break if orientation == "H" or orientation == "V"
                    end
                    puts "\n"
                    puts "--------------------------------------------------------------------------------------"
                    scoreWord = management.putWordInBoard(row, column, word, valueWord, turn, orientation)
                    if scoreWord == -1
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        puts "LA PALABRA DEBE COINCIDIR CON LA CASILLA DEL CENTRO"
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                    elsif scoreWord == -2
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        puts "LA PALABRA SE SALE DEL TABLERO"
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                    elsif scoreWord == -3
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                        puts "LA PALABRAS NO COINCIDEN"
                        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                    else
                        management.deleteSymbols(word, index)
                        score = management.changeScore(scoreWord, index)
                        turn = turn + 1
                        puts "\n"
                        puts "************************************************************"
                        puts "Valor de la palabra: #{scoreWord}"
                        puts "Puntaje total de #{players[index].name}: #{players[index].score}"
                        puts "************************************************************"
                        puts "\n"
                        gameTokensAvailable = management.getNumberAvailableTokens()
                        if gameTokensAvailable <= 1
                            playing = false
                        end
                    end
                    break if scoreWord > 0
                end
            end
        end
        index = index - 1
        if index < 0
            index = players.length-1
            turn = turn + 1
        end   
    end
    if playing == false
        winners = management.getWinners()
        puts winners
        # puts "El ganador es #{winner.name} con #{winner.score} puntos"
    end
else
    puts "El número de jugadores debe ser mayor o igual a 2 y menor o igual a 4"
end