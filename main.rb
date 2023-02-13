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
    tempHash = {
      fir
    }
    aa =con.to_json
    puts aa

    # File.open("contacts.txt", "a") do |file|
    #   file.write(Marshal.dump(con), "\n")
    # end

  elsif choice == "2"
    puts "Select contact to edit"
    File.foreach("contacts.txt") do |line| 
      data = Marshal.load(line)
      puts "#{$.} Name: #{data.f_name} #{data.l_name}    Number: #{data.number}"
    end 
    
    con = gets.chomp.to_i

    line = IO.readlines("contacts.txt")[con-1]
    line = Marshal.load(line)
    puts "Name: #{line.f_name} #{line.l_name}    Number: #{line.number}"
    f_name = gets.chomp

    line.f_name = f_name
    puts "Name: #{line.f_name} #{line.l_name}    Number: #{line.number}"

    File.writelines('contacts.txt', line)[con-1]


  elsif choice == "3"
    File.foreach("contacts.txt") do |line| 
      data = Marshal.load(line)
      puts "#{$.} Name: #{data.f_name} #{data.l_name}    Number: #{data.number}"
    end 

  elsif choice == "4"
    Contact.edit
    # inp = gets.chomp.to_i
    # File.foreach('contacts.txt').with_index do |line,line_number|
    #   line.puts line if line_number == inp  
    # end
  end

end

main