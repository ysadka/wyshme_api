require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  test 'should create items' do
    itm_name = 'Test item'
    item = Item.new(name: itm_name)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')

    itm_desc = 'This is first test item ever'
    item = Item.new(name: itm_name, description: itm_desc)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_desc, item.description,
                 'Passed and actual descriptions are different')

    itm_price = 10.32
    item = Item.new(name: itm_name, description: itm_desc, price: itm_price)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_desc, item.description,
                 'Passed and actual descriptions are different')
    assert_equal(itm_price, item.price,
                 'Passed and actual prices are different')
  end

  test 'should not create items' do
    item = Item.new
    assert_not(item.save, 'Item without name is saved')

    item.description = 'Any description here, it is test item anyway'
    assert_not(item.save, 'Item without name with description is saved')

    item.price = 12.55
    assert_not(item.save, 'Item without name with description and price is saved')
  end

  test 'should create items and add categories/boards to them' do
    itm_name = 'Test item with associations'
    item = Item.new(name: itm_name)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')

    itm_boards = [boards(:board_3), boards(:board_1)]
    item.boards = itm_boards
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_boards.size, item.boards.size,
                 'Numbers of assigned and actual boards are different')

    itm_cats = [categories(:category_0), categories(:category_7)]
    item.categories = itm_cats
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_boards.size, item.boards.size,
                 'Numbers of assigned and actual boards are different')
    assert_equal(itm_cats.size, item.categories.size,
                 'Numbers of assigned and actual categories are different')

    itm_desc = 'Ipsum test descriptsum'
    itm_boards << boards(:board_0) << boards(:board_4)
    itm_cats << categories(:category_4)
    item = Item.new(name: itm_name, description: itm_desc,
                    boards: itm_boards, categories: itm_cats)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_desc, item.description,
                 'Passed and actual descriptions are different')
    assert_equal(itm_boards.size, item.boards.size,
                 'Numbers of assigned and actual boards are different')
    assert_equal(itm_cats.size, item.categories.size,
                 'Numbers of assigned and actual categories are different')
  end

end
