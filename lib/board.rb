class Board
  attr_accessor :cells

  def initialize
    @cells = create_board_cells
  end

  def create_board_cells
    {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
    cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.length != ship.length

    letters = []
    numbers = []
    coordinate_split(coordinates, letters, numbers)
    if ship_check(coordinates) == false
      false
    elsif horizontal_placement?(letters, numbers)
      true
    elsif vertical_placement?(letters, numbers)
      true
    else
      false
    end
  end

  def coordinate_split(coordinates, letters, numbers)
    coordinates.each do |coordinate|
      letters << coordinate.split(//)[0]
      numbers << coordinate.split(//)[1]
    end
  end

  def ship_check(coordinates)
    keys = coordinates
    keys.each do |key|
      return false if @cells[key].empty? == false
      return true if @cells[key].empty? == true && keys.last == key
    end
  end

  def horizontal_placement?(letters, numbers)
    index = 1

    return false unless letters.uniq.length == 1
    numbers.each do |num|
      num = num.to_i
      if num.next != numbers[index].to_i && numbers.last.to_i != num
        return false
      elsif num.next == numbers[index].to_i && numbers.last.to_i == num.next
        return true
      elsif num.next == numbers[index].to_i && numbers.last.to_i != num
        index += 1
      end
    end
  end

  def vertical_placement?(letters, numbers)
    index = 1
    return false unless numbers.uniq.length == 1

    letters.each do |letter|
      letter = letter.ord
      if letter.next != letters[index].ord && letters.last.ord != letter
        return false
      elsif letter.next == letters[index].ord && letters.last.ord == letter.next
        return true
      elsif letter.next == letters[index].ord && letters.last.ord != letter
        index += 1
      end
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == false
      "Coordinates not valid for ship placement, try again!"
    else
      keys = coordinates
      keys.each do |key|
        @cells[key].place_ship(ship)
      end
      "Successfully placed ship!"
    end
  end

  def render(reveal = false)
    keys = @cells.keys
    coordinate_groups = keys.each_slice(4).to_a
    range = (1..coordinate_groups.length)
    print ' '
    range.step(1) { |column| print ' ' + column.to_s }
    puts "\n"
    coordinate_groups.each do |group|
      output = group.map do |coordinate|
        @cells[coordinate].render(reveal)
      end
      puts output.join(' ').prepend(group[0].byteslice(0) + ' ')
    end
  end

  def placement_options(ship) 
    h_groups = horizontal_groups
    v_groups = vertical_groups
    ship_size = ship.length
    h_options = []
    v_options = []
    h_groups.each do |group|
      group.each_cons(ship_size) { |coordinate| h_options << coordinate }
    end
    v_groups.each do |group|
      group.each_cons(ship_size) { |coordinate| v_options << coordinate }
    end
    random = rand(11)
    if random > 5
      h_options.sample
    else
      v_options.sample
    end
  end

  def horizontal_groups
    keys = @cells.keys
    coordinate_groups = keys.each_slice(4).to_a
  end

  def vertical_groups
    keys = @cells.keys
    coordinate_groups = keys.each_slice(4).to_a
    vertical = []
    index = 0
    until index == coordinate_groups.first.length
      coordinate_groups.each do |group|
        vertical << group[index]
      end
      index += 1
    end
    vertical = vertical.each_slice(4).to_a
  end
end
