defmodule ContactsappTest do
  use ExUnit.Case
  doctest Contactsapp

  test "greets the world" do
    assert Contactsapp.hello() == :world
  end
end
