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
end

def display_contacts
  @contacts = Contact.all
  puts "\n"
  @contacts.each_with_index do |con, i|
    puts "#{i+1}. #{con["f_name"]} #{con["l_name"]}: #{con["number"]}"
  end
  puts "\n"
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
    print "\nEnter first name: "
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
  when 4
    contacts = display_contacts
    puts "Select a contact:\n"
    index = gets.to_i 
    con_id = contacts[index-1].id 
    puts con_id
    @contact = Contact.find(con_id)
    @contact.destroy
    puts "\nContact deleted\n\n"
    main
  when 0
    
  else
    puts "Invalid choice"
    main
  end
end

main