require "./contact"
require 'json'

def add_contact(f_name, l_name, number)
  obj = {
    :f_name => f_name,
    :l_name => l_name,
    :number => number,
  }
  @contact = Contact.new(obj)
  @contact.save
  # @contact.save
  # File.open("contacts.txt", "a") do |file|
  #   file.puts contact.to_obj.to_json
  # end
end

def display_contacts
  # contacts = []
  # File.foreach("contacts.txt") do |line| 
  #   contacts << line
  # end
  # # puts contacts
  # puts "\n"
  # contacts.each_with_index do |c, i|
  #   c = JSON.parse(c)
  #   puts "#{i+1}. #{c["f_name"]} #{c["l_name"]} : #{c["number"]}"
  # end
  # puts "\n"
  # return contacts
  @contacts = Contact.all
  @contacts.each_with_index do |con, i|
    puts "#{i+1}. #{con["f_name"]} #{con["l_name"]}: #{con["number"]}"
  end
  return @contacts
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
    puts "\nContact added successfully.\n\n"
    main
  when 2
    display_contacts
    main
  when 3
    contacts = display_contacts
    puts "Select a contact:\n"
    index = gets.to_i 
    con_id = contacts[index-1].id 
    puts con_id
    @contact = Contact.find(con_id)
    puts @contact

    # #Gets user input
    print "(#{@contact.f_name}): "
    f_name = gets.strip
    print "(#{@contact.l_name}): "
    l_name = gets.strip
    print "(#{@contact.number}): "
    number = gets.strip
    #Maintain old value if user input is empty
    f_name = @contact.f_name if f_name==""
    l_name = @contact.l_name if l_name==""
    number = @contact.number if number==""
    obj = {
      :f_name => f_name,
      :l_name => l_name,
      :number => number,
    }
    
    @contact.update(obj)
    puts "Contact updated succe"
    main

    # con = JSON.parse(contacts[index-1])
    # #Gets user input
    # print "(#{con["f_name"]}): "
    # f_name = gets.strip
    # print "(#{con["l_name"]}): "
    # l_name = gets.strip
    # print "(#{con["number"]}): "
    # number = gets.strip
    #Maintain old value if user input is empty
    # con["f_name"] = f_name if f_name!=""
    # con["l_name"] = l_name if l_name!=""
    # con["number"] = number if number!=""
    #Save update
    # contacts[index-1] = con.to_json
    # File.open("contacts.txt", "w") do |file|
    #   file.puts contacts
    # end
    # puts "\nContact updated successfully.\n\n"
    # main
  when 4
    contacts = display_contacts
    puts "Select a contact:\n"
    index = gets.to_i 
    con_id = contacts[index-1].id 
    puts con_id
    @contact = Contact.find(con_id)
    @contact.destroy
    # contacts = display_contacts
    # puts "Delete a contact:\n"
    # index = gets.to_i 
    # contacts.delete_at(index-1)
    # File.open("contacts.txt", "w") do |file|
    #   file.puts contacts
    # end
    puts "\nContact deleted\n\n"
    main
  when 0
    
  else
    puts "Invalid choice"
    main
  end
end

main