require 'spec_helper'

class ClimbsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @climb = climbs(:one)
  end

  test "should get index" do
    get climbs_url, as: :json
    assert_response :success
  end

  test "should create climb" do
    assert_difference('Climb.count') do
      post climbs_url, params: { climb: { performance: @climb.performance, route_id: @climb.route_id, user_id: @climb.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show climb" do
    get climb_url(@climb), as: :json
    assert_response :success
  end

  test "should update climb" do
    patch climb_url(@climb), params: { climb: { performance: @climb.performance, route_id: @climb.route_id, user_id: @climb.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy climb" do
    assert_difference('Climb.count', -1) do
      delete climb_url(@climb), as: :json
    end

    assert_response 204
  end
end
