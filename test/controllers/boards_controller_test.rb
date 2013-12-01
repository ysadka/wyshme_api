require 'test_helper'

# NOTE: 10 boards are defined with fixtures, 5 per user
class BoardsControllerTest < ActionController::TestCase

  # FIXME: In some reason `rake test` command does not setup
  #   controller sometimes
  def setup
    @controller = Api::BoardsController.new
    setup_token
  end

  test 'should respond with boards' do
    get(:index, { access_token: @token })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:boards), '@boards is not assigned')
    assert_equal(5, assigns(:boards).size, '@boards size is not 5')

    get(:index, { access_token: @token, page: 1, per_page: 3 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:boards), '@boards is not assigned')
    assert_equal(2, assigns(:boards).size, '@boards size is not 2')

    get(:index, { access_token: @token, page: 1, per_page: 20 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:boards), '@boards is not assigned')
    assert_equal(0, assigns(:boards).size, '@boards size is not 0')
  end

  test 'should create board' do
    board = default_board

    post(:create, { access_token: @token, board: board })
    response_and_model_test(board, 'board', false, 'success')
  end

  test 'should create board and assign items' do
    board = default_board
    board.merge!({ item_ids: [ items(:item_4).id,
                               items(:item_7).id ] })

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')
  end

  test 'should not create board' do
    board = default_board
    board.delete(:name)

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'error')
  end

  test 'should not create board and associations' do
    board = default_board
    board.delete(:name)
    board.merge!({ item_ids: [ items(:item_70).id,
                               items(:item_3).id ] })

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'error')
  end

  test 'should create board and return existing board on show action' do
    board = default_board

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')

    board_id = JSON.parse(@response.body)['id']
    get(:show, { id: board_id, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')
  end

  test 'should create and update the board' do
    board = default_board

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')

    board_id = JSON.parse(@response.body)['id']
    board[:name] = 'New name of the board'

    patch(:update, { id: board_id, board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')
  end

  test 'should create board and its associations and then update them' do
    board = default_board
    board.merge!({ item_ids: [ items(:item_0).id,
                               items(:item_3).id ] })

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')

    board_id = JSON.parse(@response.body)['id']
    board[:name] = 'Name was changed'
    board[:item_ids] << items(:item_8).id

    patch(:update, { id: board_id, board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')
  end

  test 'should create but not update the board' do
    board = default_board

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')

    board_id = JSON.parse(@response.body)['id']
    board[:name] = nil

    patch(:update, { id: board_id, board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'error')
  end

  test 'should create and destroy the board' do
    board = default_board

    post(:create, { board: board, access_token: @token })
    response_and_model_test(board, 'board', false, 'success')

    board_id = JSON.parse(@response.body)['id']

    delete(:destroy, { id: board_id, access_token: @token })
    response_and_model_test(board, 'board', true, 'success')
  end

  def default_board
    {
      name: 'Newest board',
      description: 'My cool new board!',
      event: 'Happy day',
      event_at: '3000-01-01'
    }
  end

end
