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

  def new_contact
    f_name, l_name, number = form
    data = get_contacts

    contact = Contact.new(f_name, l_name, number)
    contact_obj = {
      f_name: contact.f_name,
      l_name: contact.l_name,
      number: contact.number
    }
    
    data << contact_obj
    save(data)
  end

  def display_contacts
    data = get_contacts
    data.each_with_index {|d, i| puts("#{i}. Name: #{d["f_name"]} #{d["l_name"]} #{" "*5} Number: #{d["number"]}")}
  end

  def delete_contact
    list = display_contacts
    user_input = gets.chomp.to_i
    list.delete_at(user_input)
    
    save(list)
  end

  def edit_contact
    list = display_contacts
    user_input = gets.chomp.to_i
    
    f_name, l_name, number = form(list[user_input]["f_name"], list[user_input]["l_name"], list[user_input]["number"])
    f_name = list[user_input]["f_name"] if f_name == ""
    l_name = list[user_input]["l_name"] if l_name == ""
    number = list[user_input]["number"] if number == ""

    updated_obj = {
      f_name: f_name,
      l_name: l_name,
      number: number
    }

    list[user_input] = updated_obj
    save(list)
  end
end