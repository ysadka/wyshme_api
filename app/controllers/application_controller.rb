class ApplicationController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session #:exception

  protected

  def load_paginated(klass, with_user = false)
    model_set = with_user ? klass.where(user_id: current_user.id) : klass

    # Request example: http://api.wyshme.com/api/items?ids=1,7,13
    # Code below will convert string "1,7,13" to [1, 7, 13],
    # removes duplications and IDs, which are less than 1.
    ids = params.fetch(:ids, "").split(',').map(&:to_i)
    ids.uniq!.delete_if { |id| id < 1 }
    if ids.empty?
      limit = params.fetch(:per_page, 10).to_i
      offset = params.fetch(:page, 0).to_i * limit

      model_set.limit(limit).offset(offset).load
    else
      # do not apply pagination if `ids` filter is given
      model_set.where(id: ids).load
    end
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
