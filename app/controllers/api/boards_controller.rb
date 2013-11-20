module Api
  class BoardsController < BaseController
    doorkeeper_for :all

    before_action :find_board, only: [:show, :update, :destroy]

    def index
      @boards = load_paginated(Board, true)

      render json: @boards, each_serializer: BoardSerializer
    end

    def create
      @board = current_user.boards.new(board_params)
      set_associations(@board, Item, params[:board][:item_ids])
      status = @board.save

      render json: @board, meta: gen_meta(status)
    end

    def show
      render json: @board
    end

    def update
      @board.assign_attributes(board_params)
      set_associations(@board, Item, params[:board][:item_ids])
      status = @board.save

      render json: @board, meta: gen_meta(status)
    end

    def destroy
      status = @board.destroy

      render json: @board, meta: gen_meta(status)
    end

    private

    def board_params
      params.require(:board).permit(:name, :description, :event, :event_at)
    end

    def find_board
      # TODO: load board only if current user is its owner
      @board = current_user.boards.where(id: params[:id]).first
    end

  end
end
