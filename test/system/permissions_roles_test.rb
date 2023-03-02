require "application_system_test_case"

class PermissionsRolesTest < ApplicationSystemTestCase
  setup do
    @permissions_role = permissions_roles(:one)
  end

  test "visiting the index" do
    visit permissions_roles_url
    assert_selector "h1", text: "Permissions roles"
  end

  test "should create permissions role" do
    visit permissions_roles_url
    click_on "New permissions role"

    fill_in "Permission", with: @permissions_role.permission_id
    fill_in "Role", with: @permissions_role.role_id
    click_on "Create Permissions role"

    assert_text "Permissions role was successfully created"
    click_on "Back"
  end

  test "should update Permissions role" do
    visit permissions_role_url(@permissions_role)
    click_on "Edit this permissions role", match: :first

    fill_in "Permission", with: @permissions_role.permission_id
    fill_in "Role", with: @permissions_role.role_id
    click_on "Update Permissions role"

    assert_text "Permissions role was successfully updated"
    click_on "Back"
  end

  test "should destroy Permissions role" do
    visit permissions_role_url(@permissions_role)
    click_on "Destroy this permissions role", match: :first

    assert_text "Permissions role was successfully destroyed"
  end
end
