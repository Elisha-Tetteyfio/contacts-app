require "application_system_test_case"

class SuburbsTest < ApplicationSystemTestCase
  setup do
    @suburb = suburbs(:one)
  end

  test "visiting the index" do
    visit suburbs_url
    assert_selector "h1", text: "Suburbs"
  end

  test "should create suburb" do
    visit suburbs_url
    click_on "New suburb"

    fill_in "City", with: @suburb.city_id
    fill_in "Name", with: @suburb.name
    fill_in "User", with: @suburb.user_id
    click_on "Create Suburb"

    assert_text "Suburb was successfully created"
    click_on "Back"
  end

  test "should update Suburb" do
    visit suburb_url(@suburb)
    click_on "Edit this suburb", match: :first

    fill_in "City", with: @suburb.city_id
    fill_in "Name", with: @suburb.name
    fill_in "User", with: @suburb.user_id
    click_on "Update Suburb"

    assert_text "Suburb was successfully updated"
    click_on "Back"
  end

  test "should destroy Suburb" do
    visit suburb_url(@suburb)
    click_on "Destroy this suburb", match: :first

    assert_text "Suburb was successfully destroyed"
  end
end
