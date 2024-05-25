require "test_helper"
require "json"

class MapsControllerTest < ActionDispatch::IntegrationTest
  test "stands rest api" do
    get "/stands"

    assert_response :success
    stands = JSON.parse(@response.body)
    assert 0 < stands.length
    first_stand = stands[0]
    assert_match /[0-9]+/, first_stand['station_id']
    assert_not_empty first_stand['name']
    assert_not_empty first_stand['address']
    assert_instance_of Integer, first_stand['num_bikes_available']
    assert_instance_of Float, first_stand['lat']
    assert_instance_of Float, first_stand['lon']
  end

  test "can see root page" do
    get root_url

    assert_select "h1", "Bysykkelstativer"
  end
end
