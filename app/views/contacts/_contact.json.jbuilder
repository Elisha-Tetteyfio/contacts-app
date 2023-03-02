json.extract! contact, :id, :fname, :lname, :phone, :birth_date, :email, :user_id, :suburb_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
