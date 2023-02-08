module Options
  def home
    puts "\n  *** Welcome to contacts app ***\n"
    puts "-----------------------------------\n\n"
    puts "1 - Add contact\n"
    puts "2 - Edit contact\n"
    puts "3 - View contacts\n"
    puts "4 - Delete contact\n"
    puts "0 - Enter 0 to quit\n\n"
    puts "Select an option:\n"
  end

  def form(f_name="", l_name="", number="")
    print "\n  Enter first name\n  (#{f_name}): "
    f_name = gets.chomp
    print "\n  Enter last name\n  (#{l_name}): "
    l_name = gets.chomp
    print "\n  Enter contact number\n  (#{number}): "
    number = gets.chomp
    return f_name, l_name, number
  end
end