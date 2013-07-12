require 'test_helper'

class VehicleLogsControllerTest < ActionController::TestCase
  setup do
    @vehicle_log = vehicle_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_log" do
    assert_difference('VehicleLog.count') do
      post :create, vehicle_log: { plate: @vehicle_log.plate, timestamp: @vehicle_log.timestamp }
    end

    assert_redirected_to vehicle_log_path(assigns(:vehicle_log))
  end

  test "should show vehicle_log" do
    get :show, id: @vehicle_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle_log
    assert_response :success
  end

  test "should update vehicle_log" do
    patch :update, id: @vehicle_log, vehicle_log: { plate: @vehicle_log.plate, timestamp: @vehicle_log.timestamp }
    assert_redirected_to vehicle_log_path(assigns(:vehicle_log))
  end

  test "should destroy vehicle_log" do
    assert_difference('VehicleLog.count', -1) do
      delete :destroy, id: @vehicle_log
    end

    assert_redirected_to vehicle_logs_path
  end
end
