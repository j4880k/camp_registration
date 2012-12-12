require 'test_helper'

class ReservationCartsControllerTest < ActionController::TestCase
  setup do
    @reservation_cart = reservation_carts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservation_carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reservation_cart" do
    assert_difference('ReservationCart.count') do
      post :create, reservation_cart: @reservation_cart.attributes
    end

    assert_redirected_to reservation_cart_path(assigns(:reservation_cart))
  end

  test "should show reservation_cart" do
    get :show, id: @reservation_cart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reservation_cart
    assert_response :success
  end

  test "should update reservation_cart" do
    put :update, id: @reservation_cart, reservation_cart: @reservation_cart.attributes
    assert_redirected_to reservation_cart_path(assigns(:reservation_cart))
  end

  test "should destroy reservation_cart" do
    assert_difference('ReservationCart.count', -1) do
      delete :destroy, id: @reservation_cart
    end

    assert_redirected_to reservation_carts_path
  end
end
