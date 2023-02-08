require './options'

def main
  options = Options.new
  options.home
  user_input = gets.chomp

  if user_input.to_i == 0
  else
    puts "Invalid option"
    main 
  end
end

main