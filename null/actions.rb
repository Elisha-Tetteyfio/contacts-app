require './options'
require './contact'
require 'json'

module Actions

  def get_contacts
    file = File.open('contacts.json', 'r')
    all_contacts = JSON.parse(file.read)
    file.close
    return all_contacts
  end

  def save(data)
    File.open('contacts.json', 'w+') do |file|
      file.write(JSON.dump(data))
    end
  end

  def edit_contact(f_name, l_name, number)
    f_name1, l_name1, number1 = form(f_name, l_name, number)
    f_name1 = f_name if f_name1 == ""
    l_name1 = l_name if l_name1 == ""
    number1 = number if number1 == ""

    return f_name1, l_name1, number1
  end

  def new_contact
    puts "#{" "*5} Add contact"
    puts "#{" "*5}--------------"

    f_name, l_name, number = form
    data = get_contacts
    opt = summary(f_name, l_name, number)

    while true 
      if opt == "1"
        if f_name.empty? || number.empty?
          puts "First name or number cannot be empty"
          f_name, l_name, number = edit_contact(f_name, l_name, number)
          opt = summary(f_name, l_name, number)
        else
          contact_obj = { f_name: f_name, l_name: l_name, number: number }
          data << contact_obj
          save(data)
          break
        end
      elsif opt == "2"
        f_name, l_name, number = edit_contact(f_name, l_name, number)
        opt = summary(f_name, l_name, number)
      elsif opt == "00"
        break
      else
        "Invalid option"
        opt = summary(f_name, l_name, number)
      end
    end
  end

  def display_contacts
    data = get_contacts
    puts "\n"
    data.each_with_index {|d, i| puts("#{i}. Name: #{d["f_name"]} #{d["l_name"]} #{" "*5} Number: #{d["number"]}")}
  end

  def delete_contact
    puts "\nSelect a contact to delete:"
    list = display_contacts
    user_input = gets.chomp.to_i
    opt = confirmation(list[user_input]["f_name"], list[user_input]["l_name"])

    while true
      if opt == "1"
        list.delete_at(user_input)
        break
      elsif opt == "2" || opt == "00"
        break
      else
        puts "Invalid option"
        opt = confirmation(list[user_input]["f_name"], list[user_input]["l_name"])
      end
    end
    
    save(list)
  end

  def edit_contacts
    puts "\nSelect a contact to edit:"
    list = display_contacts
    user_input = gets.chomp.to_i

    f_name, l_name, number =
    edit_contact(list[user_input]["f_name"], list[user_input]["l_name"], list[user_input]["number"])
    opt = summary(f_name, l_name, number)

    while true 
      if opt == "1"
        updated_obj = { f_name: f_name, l_name: l_name, number: number }
        list[user_input] = updated_obj
        save(list)
        break
      elsif opt == "2"
        f_name, l_name, number = edit_contact(f_name, l_name, number)
        opt = summary(f_name, l_name, number)
      elsif opt == "00"
        break
      else
        "Invalid option"
        opt = summary(f_name, l_name, number)
      end
    end
  end
end