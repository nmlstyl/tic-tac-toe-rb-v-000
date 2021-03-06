WIN_COMBINATIONS = [
  #horizontal
  [0,1,2],
  [3,4,5],
  [6,7,8],
  #vertical
  [0,3,6],
  [1,4,7],
  [2,5,8],
  #diagonal
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  integer = user_input.to_i
  integer - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board, index) || index.between?(0,8) == false
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count do |taken|
    taken == "X" || taken == "O"
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.select do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 =="X" && position_2 =="X" && position_3 == "X" || position_1 =="O" && position_2 =="O" && position_3 == "O"
      return win_combination
    end
  end

  if board == [" "," "," "," "," "," "," "," "," "]
    return nil
  end

end

def full?(board)
  board.none? {|board_index| board_index == " " }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    extract_index = won?(board)[0]
    return board[extract_index]
  else
    return nil
  end
end

def play(board)
  if !over?(board)
    turn(board)
    play(board)
  end

  if won?(board)
    if winner(board)["X"]
      puts "Congratulations X!"
    elsif winner(board)["O"]
      puts "Congratulations O!"
    end
  elsif draw?(board)
    puts "Cats Game!"
  end
end
