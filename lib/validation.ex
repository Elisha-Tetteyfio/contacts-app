defmodule Contactsapp.Validation do
  alias Contactsapp.Constants

  def validate_id(val) when val in ["", nil], do: {:error, Constants.err_missing_id}
  def validate_id(val) do
    case Integer.parse(val) do
      {val, ""} ->
        {:ok, val}
      _error ->
        {:error, Constants.err_invalid_id}
    end
  end

  def validate_first_name(name) when name in ["", nil], do: {:error, Constants.err_missing_first_name}
  def validate_first_name(name) do
    case is_binary(name) do
      true ->
        {:ok, String.trim(name)}
      false ->
        {:error, Constants.err_invalid_first_name}
    end
  end

  def validate_last_name(name) when name in ["", nil], do: {:ok, name}
  def validate_last_name(name) do
    case is_binary(name) do
      true ->
        {:ok, String.trim(name)}
      false ->
        {:error, Constants.err_invalid_last_name}
    end
  end
  # def validate_last_name(name) when name in ["", nil], do: {:error, Constants.err_missing_last_name}
  # def validate_last_name(name) do
  #   case is_binary(name) do
  #     true ->
  #       {:ok, String.trim(name)}
  #     false ->
  #       {:error, Constants.err_invalid_last_name}
  #   end
  # end

  @spec validate_phone_number(any) ::
          {:error, %{resp_code: <<_::24>>, resp_msg: <<_::160>>}} | {:ok, binary}
  def validate_phone_number(num) when num in ["", nil], do: {:error, Constants.err_missing_phone_number}
  def validate_phone_number(num) do
    case is_binary(num) do
      true ->
        {:ok, String.trim(num)}
      false ->
        {:error, Constants.err_invalid_phone_number}
    end
  end

  def validate_email(email) when email in ["", nil], do: {:ok, email}
  def validate_email(email) do
    case is_binary(email) do
      true ->
        {:ok, String.trim(email)}
      false ->
        {:error, Constants.err_invalid_email}
    end
  end

  def validate_body_id(val) when val in ["", nil], do: {:error, Constants.err_missing_id}
  def validate_body_id(val) do
    if is_integer(val) do
      {:ok, val}
    else
      {:error, Constants.err_invalid_id}
    end
  end
end
