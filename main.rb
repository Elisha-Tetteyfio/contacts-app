require './options'
require './actions'

def main
  include Actions
  include Options

  home
  user_input = gets.chomp

  if user_input.to_i == 0
  elsif user_input.to_i == 1
    new_contact
  elsif user_input.to_i == 3
    display_contacts
  elsif user_input.to_i == 4
    delete_contact
  else
    puts "Invalid option"
    main 
  end
end

main