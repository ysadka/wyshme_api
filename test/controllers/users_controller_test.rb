require 'test_helper'

# NOTE: 10 users are generated with fixtures
class UsersControllerTest < ActionController::TestCase

  # FIXME: In some reason `rake test` command does not setup
  #   controller sometimes
  def setup
    @controller = Api::UsersController.new
    setup_token
  end

  test "should return users" do
    get(:index, { access_token: @token })
    assert_response(:success, 'Response is not successfull')
    assert_not_nil(assigns(:users), '@users is not assigned')
    assert_equal(10, assigns(:users).size, '@users size is not equal to 10')

    get(:index, { access_token: @token, page: 1, per_page: 6 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:users), '@users is not assigned')
    assert_equal(4, assigns(:users).size, '@users size is not 4')

    get(:index, { access_token: @token, page: 2, per_page: 10 })
    assert_response(:success, 'response is not successful')
    assert_not_nil(assigns(:users), '@users is not assigned')
    assert_equal(0, assigns(:users).size, '@users size is not 0')
  end

  test 'should create user' do
    user = default_user

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')
  end

  test 'should not create user' do
    user = default_user
    user.delete(:email)

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'error')
  end

  test 'should create user and return existing user on show action' do
    user = default_user

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')

    user_id = JSON.parse(@response.body)['id']
    get(:show, { id: user_id })
    response_and_model_test(user, 'user', false, 'success')
  end

  test 'should create and update the user' do
    user = default_user

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')

    user_id = JSON.parse(@response.body)['id']
    user[:email] = 'any_new@email.com'

    patch(:update, { id: user_id, user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')
  end

  test 'should create but not update the user' do
    user = default_user

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')

    user_id = JSON.parse(@response.body)['id']
    user[:email] = nil

    patch(:update, { id: user_id, user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'error')
  end

  test 'should create and destroy the user' do
    user = default_user

    post(:create, { user: user, access_token: @token })
    response_and_model_test(user, 'user', false, 'success')

    user_id = JSON.parse(@response.body)['id']

    delete(:destroy, { id: user_id, access_token: @token })
    response_and_model_test(user, 'user', true, 'success')
  end

  def default_user
    {
      email: 'cool_user@wyshme.com',
      first_name: 'Nice',
      last_name: 'Guy',
      password: 'password',
      password_confirmation: 'password'
    }
  end

end
