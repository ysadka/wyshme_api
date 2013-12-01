module Api
  class BaseController < ::ApplicationController

    private

    def current_user
      @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def default_serializer_options
      { root: false }
    end

  end
end
