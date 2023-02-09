require './options'
require './actions'

def main
  include Actions
  include Options

  home
  user_input = gets.chomp

  if user_input == "0"
  elsif user_input.to_i == 1
    new_contact
    main
  elsif user_input.to_i ==2
    edit_contacts
    main
  elsif user_input.to_i == 3
    display_contacts
    main
  elsif user_input.to_i == 4
    delete_contact
    main
  else
    puts "Invalid option"
    main 
  end
end

main