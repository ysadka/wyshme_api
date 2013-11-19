require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  test 'should create board successfully' do
    board = Board.new(board_args)
    assert(board.save, 'Full-filled board is not saved')
    assert_equal(board_args[:name], board.name,
                 'Passed and actual names are not equal')
    assert_equal(board_args[:user], board.user,
                 'Passed and actual users are not equal')

    optionals = { event: 'My lovely event #1' }
    board = Board.new(board_args(optionals))
    assert(board.save, 'Board without event is not saved')
    assert_equal(board_args[:name], board.name,
                 'Passed and actual names are not equal')
    assert_equal(board_args[:user], board.user,
                 'Passed and actual users are not equal')
    assert_equal(optionals[:event], board.event,
                 'Passed and actual events are not equal')

    optionals[:event_at] = Date.today
    board = Board.new(board_args(optionals))
    assert(board.save, 'Board without event is not saved')
    assert_equal(board_args[:name], board.name,
                 'Passed and actual names are not equal')
    assert_equal(board_args[:user], board.user,
                 'Passed and actual users are not equal')
    assert_equal(optionals[:event], board.event,
                 'Passed and actual events are not equal')
    assert_equal(optionals[:event_at], board.event_at,
                 'Passed and actual event dates are not equal')    
  end

  test 'should not create board' do
    board = Board.new(user: users(:one))
    assert_not board.save, 'Board without name is saved'

    board = Board.new(name: 'My fourth test board')
    assert_not board.save, 'Board without user is saved'
  end

  test 'should create boards and add items to them' do
    board = Board.new(board_args)
    assert(board.save, 'Board is not saved')
    assert_equal(board_args[:name], board.name,
                 'Passed and actual names are not equal')

    itms = [items(:item_1), items(:item_10)]
    board.items = itms
    assert(board.save, 'Board is not saved when items added')
    assert_equal(itms.size, board.items.size,
                 'Numbers of assigned and actual items are different')

    itms << items(:item_39)
    board = Board.new(board_args(items: itms))
    assert(board.save, 'Board with items is not saved')
    assert_equal(board_args[:name], board.name,
                 'Passed and actual names are not equal')
    assert_equal(itms.size, board.items.size,
                 'Numbers of assigned and actual items are different')
  end

  def board_args(ext = {})
    {user: users(:one), name: 'Good board'}.merge(ext)
  end
end
