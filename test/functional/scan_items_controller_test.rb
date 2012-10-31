require 'test_helper'

class ScanItemsControllerTest < ActionController::TestCase
  setup do
    @scan_item = scan_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scan_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scan_item" do
    assert_difference('ScanItem.count') do
      post :create, :scan_item => { :in_inventory => @scan_item.in_inventory, :item_sku => @scan_item.item_sku, :quantity => @scan_item.quantity }
    end

    assert_redirected_to scan_item_path(assigns(:scan_item))
  end

  test "should show scan_item" do
    get :show, :id => @scan_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @scan_item
    assert_response :success
  end

  test "should update scan_item" do
    put :update, :id => @scan_item, :scan_item => { :in_inventory => @scan_item.in_inventory, :item_sku => @scan_item.item_sku, :quantity => @scan_item.quantity }
    assert_redirected_to scan_item_path(assigns(:scan_item))
  end

  test "should destroy scan_item" do
    assert_difference('ScanItem.count', -1) do
      delete :destroy, :id => @scan_item
    end

    assert_redirected_to scan_items_path
  end
end
