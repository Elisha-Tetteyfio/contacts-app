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

  def summary(f_name, l_name, number)
    puts "\n#{" "*4}First name: #{f_name}\n"
    puts "#{" "*4}Last name: #{l_name}\n"
    puts "#{" "*4}Contact number: #{number}\n\n"
    puts "#{" "*4}1 - Proceed to save\n"
    puts "#{" "*4}2 - Edit\n"
    puts "#{" "*4}00 - Back to menu\n"
    print "#{" "*4}"
    user_input = gets.chomp
  end

  def confirmation(f_name, l_name)
    puts "Are you sure you want to delete contact #{f_name} #{l_name}?\n"
    puts "1 - Yes"
    puts "2 - Cancel"
    puts "00 - Back to main menu"
    opt = gets.chomp
  end
end