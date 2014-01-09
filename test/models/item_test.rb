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

  test 'should create items and add categories/lists to them' do
    itm_name = 'Test item with associations'
    item = Item.new(name: itm_name)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')

    itm_lists = [lists(:list_3), lists(:list_1)]
    item.lists = itm_lists
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_lists.size, item.lists.size,
                 'Numbers of assigned and actual lists are different')

    itm_cats = [categories(:category_0), categories(:category_7)]
    item.categories = itm_cats
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_lists.size, item.lists.size,
                 'Numbers of assigned and actual lists are different')
    assert_equal(itm_cats.size, item.categories.size,
                 'Numbers of assigned and actual categories are different')

    itm_desc = 'Ipsum test descriptsum'
    itm_lists << lists(:list_0) << lists(:list_4)
    itm_cats << categories(:category_4)
    item = Item.new(name: itm_name, description: itm_desc,
                    lists: itm_lists, categories: itm_cats)
    assert(item.save, 'Item is not saved')
    assert_equal(itm_name, item.name, 'Passed and actual names are different')
    assert_equal(itm_desc, item.description,
                 'Passed and actual descriptions are different')
    assert_equal(itm_lists.size, item.lists.size,
                 'Numbers of assigned and actual lists are different')
    assert_equal(itm_cats.size, item.categories.size,
                 'Numbers of assigned and actual categories are different')
  end

end
