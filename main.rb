require './contact'
require 'json'

def main
  puts "Select option\n"
  puts "1. Add contact\n"
  puts "2. Edit contact\n"
  puts "3. View contacts\n"
  puts "4. Delete contacts\n"
  puts "5. Quit\n"

  choice = gets.chomp

  if choice == "1"
    puts "Enter first name"
    f_name = gets.chomp
    puts "Enter last name"
    l_name = gets.chomp
    puts "Enter number"
    number = gets.chomp

    con = Contact.new(f_name, l_name, number)

    File.open("contacts.txt", "a") do |file|
      file.write(Marshal.dump(con), "\n")
    end

    # File.open("contacts.txt", "r") do |file|
    #   aa = file.read
    #   puts Marshal.load(aa).f_name
    # end

  elsif choice == "3"

    # File.open("contacts.txt", "r") do |file|
    #   aa = file.readlines.map(&:chomp)
    #   puts Marshal.load(aa)
    # end

    File.foreach("contacts.txt") do |line| 
      data = Marshal.load(line)
      puts "Name: #{data.f_name} #{data.l_name}    Number: #{data.number}"
    end 

  end

end

main