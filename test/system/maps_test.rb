require "application_system_test_case"

class MapsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "h1", text: "Bysykkelstativer"
    assert_selector "div[id=map]"
  end
end
