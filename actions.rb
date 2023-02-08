require './options'
require './contact'
require 'json'

module Actions

  def get_contacts
    file = File.open('contacts.json', 'r')
    all_contacts = JSON.parse(file.read)
    return all_contacts
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

    File.open('contacts.json', 'w+') do |file|
      file.write(JSON.dump(data))
    end
  end

  def display_contacts
    data = get_contacts
    data.each_with_index {|d, i| puts("#{i}. Name: #{d["f_name"]} #{d["l_name"]} #{" "*5} Number: #{d["number"]}")}
  end

  def delete_contact
    list = display_contacts
    user_input = gets.chomp.to_i
    list.delete_at(user_input)
    
    File.open('contacts.json', 'w+') do |file|
      file.write(JSON.dump(list))
    end
  end
end