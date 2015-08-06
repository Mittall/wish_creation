require 'test_helper'

class EventProductsControllerTest < ActionController::TestCase
  setup do
    @event_product = event_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_product" do
    assert_difference('EventProduct.count') do
      post :create, event_product: { event_id: @event_product.event_id, price_to_gain: @event_product.price_to_gain, product_id: @event_product.product_id }
    end

    assert_redirected_to event_product_path(assigns(:event_product))
  end

  test "should show event_product" do
    get :show, id: @event_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_product
    assert_response :success
  end

  test "should update event_product" do
    patch :update, id: @event_product, event_product: { event_id: @event_product.event_id, price_to_gain: @event_product.price_to_gain, product_id: @event_product.product_id }
    assert_redirected_to event_product_path(assigns(:event_product))
  end

  test "should destroy event_product" do
    assert_difference('EventProduct.count', -1) do
      delete :destroy, id: @event_product
    end

    assert_redirected_to event_products_path
  end
end
