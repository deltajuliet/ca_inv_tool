require 'test_helper'

class InventoryItemsControllerTest < ActionController::TestCase
  setup do
    @inventory_item = inventory_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_item" do
    assert_difference('InventoryItem.count') do
      post :create, :inventory_item => { :asin => @inventory_item.asin, :auction_title => @inventory_item.auction_title, :brand => @inventory_item.brand, :buy_it_now_price => @inventory_item.buy_it_now_price, :channel_advisor_store_price => @inventory_item.channel_advisor_store_price, :classification => @inventory_item.classification, :description => @inventory_item.description, :flag => @inventory_item.flag, :inventory_number => @inventory_item.inventory_number, :labels => @inventory_item.labels, :mpn => @inventory_item.mpn, :picture_urls => @inventory_item.picture_urls, :received_in_inventory => @inventory_item.received_in_inventory, :retail_price => @inventory_item.retail_price, :second_chance_offer_price => @inventory_item.second_chance_offer_price, :seller_cost => @inventory_item.seller_cost, :starting_bid => @inventory_item.starting_bid, :total_quantity => @inventory_item.total_quantity, :upc => @inventory_item.upc, :weight => @inventory_item.weight }
    end

    assert_redirected_to inventory_item_path(assigns(:inventory_item))
  end

  test "should show inventory_item" do
    get :show, :id => @inventory_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @inventory_item
    assert_response :success
  end

  test "should update inventory_item" do
    put :update, :id => @inventory_item, :inventory_item => { :asin => @inventory_item.asin, :auction_title => @inventory_item.auction_title, :brand => @inventory_item.brand, :buy_it_now_price => @inventory_item.buy_it_now_price, :channel_advisor_store_price => @inventory_item.channel_advisor_store_price, :classification => @inventory_item.classification, :description => @inventory_item.description, :flag => @inventory_item.flag, :inventory_number => @inventory_item.inventory_number, :labels => @inventory_item.labels, :mpn => @inventory_item.mpn, :picture_urls => @inventory_item.picture_urls, :received_in_inventory => @inventory_item.received_in_inventory, :retail_price => @inventory_item.retail_price, :second_chance_offer_price => @inventory_item.second_chance_offer_price, :seller_cost => @inventory_item.seller_cost, :starting_bid => @inventory_item.starting_bid, :total_quantity => @inventory_item.total_quantity, :upc => @inventory_item.upc, :weight => @inventory_item.weight }
    assert_redirected_to inventory_item_path(assigns(:inventory_item))
  end

  test "should destroy inventory_item" do
    assert_difference('InventoryItem.count', -1) do
      delete :destroy, :id => @inventory_item
    end

    assert_redirected_to inventory_items_path
  end
end
