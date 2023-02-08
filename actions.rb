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
end