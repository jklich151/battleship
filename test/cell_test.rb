require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

  def test_cell_is_empty
    cell = Cell.new("B4")
    assert_equal true, cell.empty?
    cell.ship = true
    assert_equal false, cell.empty?
  end
end
