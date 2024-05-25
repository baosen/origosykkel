require "application_system_test_case"

class MapsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "h1", "Bysykkelstativer"
  end
end
