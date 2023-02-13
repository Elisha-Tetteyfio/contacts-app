require "./contact"
require 'json'

def add_contact(f_name, l_name, number)
  contact = Contact.new(f_name, l_name, number)
  File.open("contacts.txt", "a") do |file|
    file.puts contact.to_obj.to_json
  end
end

def display_contacts
  contacts = []
  File.foreach("contacts.txt") do |line| 
    contacts << line
  end
  # puts contacts
  contacts.each_with_index do |c, i|
    c = JSON.parse(c)
    puts "#{i+1}. #{c["f_name"]} #{c["l_name"]} : #{c["number"]}"
  end
  return contacts
end

def main
  puts "1. Add contact"
  puts "2. List contacts"
  puts "3. Edit contact"
  puts "4. Delete contact"
  puts "0. Exit"
  print "Enter your choice: "
  choice = gets.to_i

  case choice
  when 1
    print "Enter first name: "
    f_name = gets.strip
    print "Enter last name: "
    l_name = gets.strip
    print "Enter number: "
    number = gets.strip
    add_contact(f_name, l_name, number)
    puts "Contact added successfully."
    main
  when 2
    display_contacts
    main
  when 3
    contacts = display_contacts
    puts "Select a contact:\n"
    index = gets.to_i 
    con = JSON.parse(contacts[index-1])
    #Gets user input
    print "(#{con["f_name"]}): "
    f_name = gets.strip
    print "(#{con["l_name"]}): "
    l_name = gets.strip
    print "(#{con["number"]}): "
    number = gets.strip
    #Maintain old value if user input is empty
    con["f_name"] = f_name if f_name!=""
    con["l_name"] = l_name if l_name!=""
    con["number"] = number if number!=""
    #Save update
    contacts[index-1] = con.to_json
    File.open("contacts.txt", "w") do |file|
      file.puts contacts
    end
    puts "Contact updated successfully."
    main
  when 4
    contacts = display_contacts
    puts "Delete a contact:\n"
    index = gets.to_i 
    contacts.delete_at(index-1)
    File.open("contacts.txt", "w") do |file|
      file.puts contacts
    end
    puts "Contact deleted"
    main
  when 0
    
  else
    puts "Invalid choice"
    main
  end
end

main