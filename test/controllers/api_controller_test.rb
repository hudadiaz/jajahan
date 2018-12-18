require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "should get data" do
    data_name = [
      "/dun",
      "/subdistrict",
      "/license-type",
      "/country",
      "/education-detail",
      "/education-narrow",
      "/state",
      "/user_title",
      "/education-broad",
      "/bank",
      "/parliament",
      "/education-level",
      "/religion",
      "/district",
      "/gender"
    ]
    data_name.each do |name|
      get data_path(name: name)
      assert_response :success
    end
  end

  test "should get postcode" do
    postcode_name = [
      "/wp-putrajaya",
      "/perak",
      "/wp-kuala-lumpur",
      "/pulau-pinang",
      "/kedah",
      "/melaka",
      "/negeri-sembilan",
      "/sarawak",
      "/terengganu",
      "/johor",
      "/selangor",
      "/sabah",
      "/kelantan",
      "/wp-labuan",
      "/perlis",
      "/pahang"
    ]
    postcode_name.each do |name|
      get postcode_path(name: name)
      assert_response :success
    end
  end

  test "should not get invalid data" do
    get data_path(name: 'invalid_name')
    assert_response :not_found
  end

  test "should not get invalid postcode" do
    get postcode_path(name: 'invalid_name')
    assert_response :not_found
  end
end
