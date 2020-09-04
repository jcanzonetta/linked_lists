class Node
  attr_accessor :val, :next_node

  def initialize(val = nil, next_node = nil)
    @val = val
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head = node
    end
  end

  # returns the total number of nodes in the list
  def size
    return 0 if @head.nil?

    # if next_node nil? return count
    # else add 1 to count
    # change to next node
    node = @head
    count = 1
    until node.next_node.nil?
      count += 1
      node = node.next_node
    end

    count
  end

  # returns the first node in the list
  attr_reader :head

  # returns the last node in the list
  attr_reader :tail

  # returns the node at the given index
  def at(index)
    if index < 0 || @head.nil? || index > size
      return 'out of bounds'
    elsif index == 0
      return @head
    end

    node = @head
    i = 0
    while i < index
      i += 1
      node = node.next_node
    end

    node
  end

  # pop removes the last element from the list
  def pop
    return 'nothing to pop' if @head.nil?

    node = @head
    node = node.next_node until node.next_node.next_node.nil?

    node.next_node = nil
    @tail = node
  end

  # returns true if the passed in value is in the list and otherwise returns false.
  def contains?(value)
    return false if @head.nil?

    node = @head

    until node.next_node.nil?
      if node.val == value
        return true
      else
        node = node.next_node
      end
    end

    false
  end

  # returns the index of the node containing value, or nil if not found.
  def find(value)
    return nil if @head.nil?

    node = @head
    index = 0

    until node.next_node.nil?
      if node.val == value
        return index
      else
        node = node.next_node
        index += 1
      end
    end

    nil
  end

  def to_s
    node = @head
    output_string = "( #{node.val} ) -> "
    until node.next_node.nil?
      node = node.next_node
      output_string += "( #{node.val} ) -> "
    end
    output_string + 'nil'
  end

  # inserts the node with the provided value at the given index
  def insert_at(value, index)
    if @head.nil?
      return 'empty list'
    elsif index > size - 1
      return 'out of bounds'
    elsif index == 0
      return 'use #prepend(value) instead'
    elsif index == size - 1
      return 'use #append(value) instead'
    end

    node = @head
    i = 0
    until i == index - 1
      node = node.next_node
      i += 1
    end

    shifted_node = node.next_node
    node.next_node = Node.new(value, shifted_node)
  end

  # that removes the node at the given index.
  def remove_at(index)
    if @head.nil?
      return 'empty list'
    elsif index > size - 1 || index < 0
      return 'out of bounds'
    elsif index == 0
      node = @head.next
      @head = node
      return nil
    elsif index == size - 1
      return 'try #pop() instead'
    end

    node = @head
    i = 0

    until i == index - 1
      node = node.next_node
      i += 1
    end

    node.next_node = node.next_node.next_node
  end
end

list = LinkedList.new
list.append(2)
list.append(4)
list.prepend(1)
list.append(5)
list.append(6)
list.append(101)
list.prepend(77)
puts "Head value: #{list.head.val}"
puts "Tail value: #{list.tail.val}"
puts "Size: #{list.size}"
puts "Value at index 2: #{list.at(2).val}"
puts list

list.pop
puts "\nList was popped!\n\n"
puts "Head value: #{list.head.val}"
puts "Tail value: #{list.tail.val}"
puts "Size: #{list.size}"
puts "Value at index 2: #{list.at(2).val}"
puts list
puts "Contains 4?: #{list.contains?(4)}"
puts "Contains 99?: #{list.contains?(99)}"
puts "Find 4: #{list.find(4)}"
puts "Find 99: #{list.find(99)}"
list.insert_at(1000, 3)
puts list
list.remove_at(3)
puts list
