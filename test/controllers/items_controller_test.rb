require 'test_helper'

# NOTE: 100 items are generated with fixtures
class ItemsControllerTest < ActionController::TestCase

  # FIXME: In some reason `rake test` command does not setup
  #   controller sometimes
  def setup
    @controller = Api::ItemsController.new
    setup_token
  end

  test "should respond with items" do
    get :index, { access_token: @token }
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:items), '@items is not assigned')
    assert_equal(10, assigns(:items).size, '@items size is not 10')

    get(:index, { access_token: @token, page: 11, per_page: 9 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:items), '@items is not assigned')
    assert_equal(1, assigns(:items).size, '@items size is not 1')

    get(:index, { access_token: @token, page: 5, per_page: 20 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:items), '@items is not assigned')
    assert_equal(0, assigns(:items).size, '@items size is not 0')
  end

  test 'should create item' do
    item = default_item

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create item and assign boards' do
    item = default_item
    item.merge!({ board_ids: [boards(:board_1).id, boards(:board_3).id] })

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create item and assign categories' do
    item = default_item
    item.merge!({ category_ids: [ categories(:category_4).id,
                                  categories(:category_7).id ] })

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create item and assign boards and categories' do
    item = default_item
    item.merge!({ board_ids: [boards(:board_2).id, boards(:board_5).id] })
    item.merge!({ category_ids: [ categories(:category_0).id,
                                  categories(:category_3).id ] })

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should not create item' do
    item = default_item
    item.delete(:name)

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'error')
  end

  test 'should not create item and associations' do
    item = default_item
    item.delete(:name)
    item.merge!({ board_ids: [boards(:board_2).id, boards(:board_5).id] })
    item.merge!({ category_ids: [ categories(:category_0).id,
                                  categories(:category_3).id ] })

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'error')
  end

  test 'should create item and return existing item on show action' do
    item = default_item

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')

    item_id = JSON.parse(@response.body)['item']['id']
    get(:show, { access_token: @token, id: item_id })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create and update the item' do
    item = default_item

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')

    item_id = JSON.parse(@response.body)['item']['id']
    item[:name] = 'New name of the item'

    patch(:update, { access_token: @token, id: item_id, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create item and its associations and then update them' do
    item = default_item
    item.merge!({ board_ids: [boards(:board_2).id, boards(:board_5).id] })
    item.merge!({ category_ids: [ categories(:category_0).id,
                                  categories(:category_3).id ] })

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')

    item_id = JSON.parse(@response.body)['item']['id']
    item[:name] = 'Name was changed'
    item[:board_ids][1] = boards(:board_3).id
    item[:category_ids] << categories(:category_8).id

    patch(:update, { access_token: @token, id: item_id, item: item })
    response_and_model_test(item, 'item', false, 'success')
  end

  test 'should create but not update the item' do
    item = default_item

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')

    item_id = JSON.parse(@response.body)['item']['id']
    item[:name] = nil

    patch(:update, { access_token: @token, id: item_id, item: item })
    response_and_model_test(item, 'item', false, 'error')
  end

  test 'should create and destroy the item' do
    item = default_item

    post(:create, { access_token: @token, item: item })
    response_and_model_test(item, 'item', false, 'success')

    item_id = JSON.parse(@response.body)['item']['id']

    delete(:destroy, { access_token: @token, id: item_id })
    response_and_model_test(item, 'item', true, 'success')
  end

  def default_item
    { name: 'New cool item', description: 'Very nice', price: '12.9' }
  end

end
