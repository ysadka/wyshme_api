require 'test_helper'

class ListTest < ActiveSupport::TestCase

  test 'should create list successfully' do
    list = List.new(list_args)
    assert(list.save, 'Full-filled list is not saved')
    assert_equal(list_args[:name], list.name,
                 'Passed and actual names are not equal')
    assert_equal(list_args[:user], list.user,
                 'Passed and actual users are not equal')

    optionals = { event: 'My lovely event #1' }
    list = List.new(list_args(optionals))
    assert(list.save, 'List without event is not saved')
    assert_equal(list_args[:name], list.name,
                 'Passed and actual names are not equal')
    assert_equal(list_args[:user], list.user,
                 'Passed and actual users are not equal')
    assert_equal(optionals[:event], list.event,
                 'Passed and actual events are not equal')

    optionals[:event_at] = Date.today
    list = List.new(list_args(optionals))
    assert(list.save, 'List without event is not saved')
    assert_equal(list_args[:name], list.name,
                 'Passed and actual names are not equal')
    assert_equal(list_args[:user], list.user,
                 'Passed and actual users are not equal')
    assert_equal(optionals[:event], list.event,
                 'Passed and actual events are not equal')
    assert_equal(optionals[:event_at], list.event_at,
                 'Passed and actual event dates are not equal')    
  end

  test 'should not create list' do
    list = List.new(user: users(:one))
    assert_not list.save, 'List without name is saved'

    list = List.new(name: 'My fourth test list')
    assert_not list.save, 'List without user is saved'
  end

  test 'should create lists and add items to them' do
    list = List.new(list_args)
    assert(list.save, 'List is not saved')
    assert_equal(list_args[:name], list.name,
                 'Passed and actual names are not equal')

    itms = [items(:item_1), items(:item_10)]
    list.items = itms
    assert(list.save, 'List is not saved when items added')
    assert_equal(itms.size, list.items.size,
                 'Numbers of assigned and actual items are different')

    itms << items(:item_39)
    list = List.new(list_args(items: itms))
    assert(list.save, 'list with items is not saved')
    assert_equal(list_args[:name], list.name,
                 'Passed and actual names are not equal')
    assert_equal(itms.size, list.items.size,
                 'Numbers of assigned and actual items are different')
  end

  def list_args(ext = {})
    {user: users(:one), name: 'Good list'}.merge(ext)
  end
end
