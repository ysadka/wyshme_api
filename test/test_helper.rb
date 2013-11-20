ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  #include Devise::TestHelpers
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def check_meta(status = nil)
    return unless status

    meta = JSON.parse(@response.body)['meta']
    if meta
      assert_equal(status, meta['status'], 'unexpected status of the operation')
    end
  end

  def fields_equality_test(fields, resp)
    fields.each do |k, v|
      next if [:password, :password_confirmation].include?(k)

      if v.is_a?(Array) && resp[k].is_a?(Array)
        v.sort! 
        resp[k].sort!
      end

      assert_equal(v, resp[k], "#{ k } value is not the same as posted")
    end
  end

  def response_and_model_test(src, model_name, deleted, status = nil)
    $stderr.puts @response.code if @response.code.to_i > 200
    assert_response(:success, 'response is not successful')

    assert_not_nil(assigns(model_name.to_sym),
                   "@#{ model_name } is not assigned")

    res_model = JSON.parse(@response.body)[model_name].symbolize_keys!
    assert_equal(deleted, res_model[:is_deleted],
                 "@#{ model_name } is #{ deleted ? 'not ' : '' }" \
                 'marked as deleted')

    assert_instance_of(Array, res_model[:errors],
                       'errors field is not an Array')
    if status == 'error'
      assert_not(res_model[:errors].empty?, 'errors field is empty')
      res_model[:errors].each do |err|
        assert_instance_of(Hash, err, 'error is not a Hash')
        assert_equal(1, err.size, 'error should contain only one field')
      end
    end

    check_meta(status)

    fields_equality_test(src, res_model)
  end

  def setup_token
    user = users(:one)
    application = Doorkeeper::Application.create!(name: "MyApp",
                                                  redirect_uri: "http://wyshme.com")
    @token = Doorkeeper::AccessToken.create!(application_id: application.id,
                                             resource_owner_id: user.id).token
  end

end
