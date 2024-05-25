require "test_helper"
require "json"

class MapsControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
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
end
