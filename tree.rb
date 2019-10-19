class Tree
  attr_accessor :data, :start, :finish

  def initialize(data)
    self.data = data
  end

  def active
    data.flatten.select{|n| n.active }
  end

  def nearby(node)
    [
      get(node.r, node.c - 1),
      get(node.r, node.c + 1),
      get(node.r - 1, node.c),
      get(node.r - 1, node.c + 1),
      get(node.r - 1, node.c - 1),
      get(node.r + 1, node.c),
      get(node.r + 1, node.c + 1),
      get(node.r + 1, node.c - 1),
    ].compact.select(&:available?)
  end

  def get_node_from_value value
    data.flatten.select{|n| n.has_value? value}.first
  end

  def get(r, c)
    out_of_range = r < 0 || r >= data.count || c < 0 || c >= data[0].count
    out_of_range ? nil : data[r][c]
  end

  def set(node)
    data[node.r][node.c] = node
  end

  def print
    data.each do |row|
      printable_row = row.map do |column|
        column.v
      end.join(" | ")
      puts "|" + printable_row + "|"
    end
    puts "\n"
  end

  def print_processed
    data.each do |row|
      printable_row = row.map do |column|
        column.locked || column.active ? "P" : " "
      end.join(" | ")
      puts "|" + printable_row + "|"
    end
    puts "\n"
  end
end
