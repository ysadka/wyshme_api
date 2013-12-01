module Api
  class ItemsController < BaseController
    doorkeeper_for :create, :update, :destroy

    before_action :find_item, only: [:show, :update, :destroy]

    def index
      @items = load_paginated(Item)

      render json: @items, each_serializer: ItemSerializer
    end

    def create
      @item = Item.new(item_params)
      set_item_associations
      status = @item.save

      render json: @item, meta: gen_meta(status)
    end

    def show
      render json: @item
    end

    def update
      @item.assign_attributes(item_params)
      set_item_associations
      status = @item.save

      render json: @item, meta: gen_meta(status)
    end

    def destroy
      status = @item.destroy

      render json: @item, meta: gen_meta(status)
    end

    private

    def item_params
      params.require(:item).permit(:name, :description, :price)
    end

    def find_item
      @item = Item.find(params[:id])
    end

    def set_item_associations
      set_associations(@item, Category, params[:item][:category_ids])
    end

  end
end
