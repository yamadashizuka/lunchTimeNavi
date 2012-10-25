require 'test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post :create, restaurant: { address: @restaurant.address, email: @restaurant.email, fridayUp: @restaurant.fridayUp, startTime: @restaurant.startTime, memo: @restaurant.memo, mondayUp: @restaurant.mondayUp, name: @restaurant.name, reservation: @restaurant.reservation, saturdayUp: @restaurant.saturdayUp, sundayUp: @restaurant.sundayUp, telephoneNumber: @restaurant.telephoneNumber, thursdayUp: @restaurant.thursdayUp, endTime: @restaurant.endTime, tuesdayUp: @restaurant.tuesdayUp, url: @restaurant.url, wednesdayUp: @restaurant.wednesdayUp }
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should show restaurant" do
    get :show, id: @restaurant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @restaurant
    assert_response :success
  end

  test "should update restaurant" do
    put :update, id: @restaurant, restaurant: { address: @restaurant.address, email: @restaurant.email, fri: @restaurant.fri, from: @restaurant.from, memo: @restaurant.memo, mon: @restaurant.mon, name: @restaurant.name, reservation: @restaurant.reservation, sat: @restaurant.sat, sun: @restaurant.sun, tel: @restaurant.tel, thu: @restaurant.thu, to: @restaurant.to, tue: @restaurant.tue, url: @restaurant.url, wed: @restaurant.wed }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete :destroy, id: @restaurant
    end

    assert_redirected_to restaurants_path
  end
end
