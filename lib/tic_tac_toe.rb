require 'pry'

class TicTacToe
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        if index >= 0 && index <= 8
            position_taken?(index) ? false : true
        else
            false
        end
    end

    def turn_count
        count = 0
        @board.each do |space|
            if space != " "
                count += 1
            end
        end
        count
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        puts "Which space would you like? (enter 1 - 9)"
        input = gets.chomp
        index = input_to_index(input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        won = []
        WIN_COMBINATIONS.each do |combination|
            if @board[combination[0]] != " "
                if @board[combination[0]] == @board[combination[1]] && @board[combination[0]] == @board[combination[2]]
                    won = combination
                end
            end
        end
        won == [] ? false : won
    end

    def full?
        @board.each do |index|
            if index == " "
                return false
            end
        end
        true
    end

    def draw?
        !won? && full? ? true : false
    end

    def over?
        draw? || won? ? true : false        
    end

    def winner
        if !won?
            nil
        else
            if @board[won?[0]] == " "
                nil
            else
                @board[won?[0]]
            end
        end
    end

    def play
        # binding.pry
        while !over? do
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end
end