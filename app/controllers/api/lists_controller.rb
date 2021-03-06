module Api
  class ListsController < BaseController
    doorkeeper_for :all

    before_action :find_list, only: [:show, :update, :destroy]

    def index
      @lists = load_paginated(List, true)

      render json: @lists, each_serializer: ListSerializer
    end

    def create
      @list = current_user.lists.new(list_params)
      set_associations(@list, Item, params[:list][:item_ids])
      status = @list.save

      render json: @list, meta: gen_meta(status)
    end

    def show
      render json: @list
    end

    def update
      @list.assign_attributes(list_params)
      set_associations(@list, Item, params[:list][:item_ids])
      status = @list.save

      render json: @list, meta: gen_meta(status)
    end

    def destroy
      status = @list.destroy

      render json: @list, meta: gen_meta(status)
    end

    private

    def list_params
      params.require(:list).permit(:name, :description, :event, :event_at)
    end

    def find_list
      # TODO: load list only if current user is its owner
      @list = current_user.lists.where(id: params[:id]).first
    end

  end
end
