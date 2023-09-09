defmodule Contactsapp.Macro do
  defmacro const(name, value) do
    quote do
      @doc "Constant #{unquote(name)}"
      def unquote(:"#{name}")(), do: unquote(value)
    end
  end
end



defmodule Contactsapp.Constants do
  import Contactsapp.Macro

  # Validation error messages
  const :err_missing_id, %{ resp_code: "050", resp_msg: "Missing id in request" }
  const :err_invalid_id, %{ resp_code: "051", resp_msg: "Invalid id" }
  const :err_missing_first_name, %{ resp_code: "052", resp_msg: "Missing first name" }
  const :err_invalid_first_name, %{ resp_code: "053", resp_msg: "Invalid first name" }
  const :err_invalid_last_name, %{ resp_code: "054", resp_msg: "Invalid last name" }
  const :err_missing_phone_number, %{ resp_code: "055", resp_msg: "Missing phone number" }
  const :err_invalid_phone_number, %{ resp_code: "056", resp_msg: "Invalid phone number" }
  const :err_invalid_email, %{ resp_code: "057", resp_msg: "Invalid e-mail" }

  # Other response messages
  const :success_created, %{ resp_code: "00", resp_msg: "Contact successfully created" }
  const :success_updated, %{ resp_code: "00", resp_msg: "Contact successfully updated" }
  const :success_deleted, %{ resp_code: "00", resp_msg: "Contact successfully deleted" }
  const :no_contacts_found, %{ resp_code: "020", resp_msg: "No contacts found" }
  const :contact_not_found, %{ resp_code: "021", resp_msg: "Contact does not exist" }

end
