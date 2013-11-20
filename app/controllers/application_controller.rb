class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session #:exception

  protected

  def load_paginated(klass, with_user = false)
    limit = params.fetch(:per_page, 10).to_i
    offset = params.fetch(:page, 0).to_i * limit

    model_set = with_user ? klass.where(user_id: current_user.id) : klass
    model_set.limit(limit).offset(offset).load
  end

  def set_associations(to, assoc_class, ids)
    if ids.is_a?(Array) && !ids.empty?
      assoc_method = "#{ assoc_class.to_s.pluralize.downcase }="
      to.send(assoc_method, assoc_class.where(id: ids))
    end
  end

  def gen_meta(status)
    {}.tap do |h|
      h[:action] = action_name
      h[:status] = status ? 'success' : 'error'
    end
  end

end
