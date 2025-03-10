
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value, next_node = nil)
    @data = value
    @next = next_node
  end
end

# Defines the singly linked list
class LinkedList
    def initialize
      @head = nil # keep the head private. Not accessible outside this class
      @tail = nil
      @length = 0
    end

    # method to add a new node with the specific data value in the linked list
    # insert the new node at the beginning of the linked list
    # Time Complexity: O(1) 
    # Space Complexity: O(1) 
    def add_first(value)
      new_node = Node.new(value)
      if !@head 
        @head = new_node
        @tail = new_node
      else 
        new_node = Node.new(value)
        new_node.next = @head
        @head = new_node
      end
      @length += 1
      return
    end

    # method to find if the linked list contains a node with specified value
    # returns true if found, false otherwise
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def search(value)
      curr = @head
      while curr
        return true if curr.data == value
        curr = curr.next
      end
      return false
    end

    # method to return the max value in the linked list
    # returns the data value and not the node
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def find_max
      return if !@head
      curr = @head
      max = curr.data
      while curr
        if max < curr.data 
          max = curr.data
        end
        curr = curr.next 
      end
      return max
    end

    # method to return the min value in the linked list
    # returns the data value and not the node
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def find_min
      return if !@head
      curr = @head
      min = curr.data
      while curr
        if min > curr.data 
          min = curr.data
        end
        curr = curr.next 
      end
      return min
    end


    # method that returns the length of the singly linked list
    # Time Complexity:  O(1) (was O(n) updated class to keep track on length)
    # Space Complexity: O(1) 
    def length
      # count = 0
      # curr = @head
      # while curr && @head
      #   curr = curr.next
      #   count += 1
      # end
      # return count
      return @length
    end

    # method that returns the value at a given index in the linked list
    # index count starts at 0
    # returns nil if there are fewer nodes in the linked list than the index value
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def get_at_index(index)
      target_node = node_at_index(index)
      return if !target_node
      return target_node.data 
    end

    def node_at_index(index)
      length = length()
      return if length - 1 < index ||  index < 0
      curr = @head
      count = 0
      while index != count
        curr = curr.next
        count += 1
      end
      return curr
    end

    # method to return a string of all the values in the linked list
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def visit
      node_values = ""
      curr = @head
      while curr
        node_values << curr.data.to_s
        curr = curr.next
      end
      return node_values
    end

    # method to delete the first node found with specified value
    # Time Complexity:  O(n) where n is the number of nodes
    # Space Complexity: O(1) 
    def delete(value)
      return if !@head
      curr = @head
      if curr.data == value
        delete_first_node()
      else
        while curr.next
          if curr.next.data == value
            remove_next_node(curr)
          else
            curr = curr.next
          end
        end
      end
      @length -= 1
      return 
    end

    def delete_first_node
      temp = @head
      @head = @head.next
      temp.next = nil
    end

    def remove_next_node(node)
      temp = node.next 
      node.next = node.next.next
      temp.next = nil
      @tail = node if !node.next
    end

    # method to reverse the singly linked list
    # note: the nodes should be moved and not just the values in the nodes
    # Time Complexity:  O(n)
    # Space Complexity: passing pointer not list to rec statck so O(n)
    def reverse
      return if !@head
      curr = @head
      @tail = curr
      reverse_links(curr)
    end

    def reverse_links(curr)
      if !curr.next
        @head = curr
        return
      end
      reverse_links(curr.next)
      curr.next.next = curr
      curr.next = nil
      return 
    end

    ## Advanced Exercises
    # returns the value at the middle element in the singly linked list
    # Time Complexity:  O(n)
    # Space Complexity: O(1) 
    def find_middle_value
      return if !@head
      fast,slow = @head, @head
      while fast.next && fast.next.next
        fast = fast.next.next
        slow = slow.next
      end
      return slow.data
    end

    # find the nth node from the end and return its value
    # assume indexing starts at 0 while counting to n
    # Time Complexity:  O(n)
    # Space Complexity: O(1) 
    def find_nth_from_end(n)
      target_node = node_at_index(length() - n - 1)
      return if !target_node
      return target_node.data
    end

    # checks if the linked list has a cycle. A cycle exists if any node in the
    # linked list links to a node already visited.
    # returns true if a cycle is found, false otherwise.
    # Time Complexity:  O(n)
    # Space Complexity: O(1) 
    def has_cycle
      return false if !@head
      fast, slow = @head, @head
      while fast.next.next
        fast = fast.next.next
        slow = slow.next
        if fast == slow
          return true
        end
      end
      return false
    end


    # Additional Exercises 
    # returns the value in the first node
    # returns nil if the list is empty
    # Time Complexity:  O(1)
    # Space Complexity: O(1)  
    def get_first
      return @head.data if @head
      return 
    end

    # method that inserts a given value as a new last node in the linked list
    # Time Complexity:  O(1)
    # Space Complexity: O(1) 
    def add_last(value)
      new_node = Node.new(value)
      if @tail
        @tail.next = new_node
        @tail = new_node
      else 
        @head = new_node
        @tail = new_node
      end
      @length += 1
      return 
    end


    # method that returns the value of the last node in the linked list
    # returns nil if the linked list is empty
    # Time Complexity:  O(1)
    # Space Complexity: O(1) 
    def get_last
      return if !@tail
      return @tail.data
    end

    # method to insert a new node with specific data value, assuming the linked
    # list is sorted in ascending order
    # Time Complexity:  O(n)
    # Space Complexity: O(1) 
    def insert_ascending(value)
      new_node = Node.new(value)
      if !@head || value <= @head.data
        new_node.next = @head 
        @head = new_node
        @tail = new_node
        @length += 1
        return
      end
      curr = @head 
      while curr.next && curr.next.data <= value
        curr = curr.next
      end
      temp = curr.next
      @tail = new_node if !curr.next
      curr.next =  new_node
      new_node.next = temp
      @length += 1
      return 
    end

    # Helper method for tests
    # Creates a cycle in the linked list for testing purposes
    # Assumes the linked list has at least one node
    def create_cycle
      return if @head == nil # don't do anything if the linked list is empty

      # navigate to last node
      current = @head
      while current.next != nil
          current = current.next
      end

      current.next = @head # make the last node link to first node
    end
end
