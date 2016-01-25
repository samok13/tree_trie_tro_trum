require 'letter_node'

class DictionaryTree

  attr_reader :root, :num_words, :num_letters

  def initialize(array = nil)
    @root = LetterNode.new(nil)
    @num_letters = 0
    @num_words = 0

    if array
      array.each do |word_array|
        self.insert_word(word_array[0], word_array[1])
      end
    end
  end

  def definition_of(string)
    last_node, index = self.find_last_child(@root.children, string, 0)
    if last_node
      last_node.definition
    else 
      nil
    end
  end

  def find_last_child(children_nodes, string, index)
    if children_nodes
      new_node = nil
      children_nodes.each do |node|
        if string[index] == node.letter
          new_node = node
          break
        end
      end

      if new_node == nil || string.length-1 == index
        [new_node, index]
      else
        find_last_child(new_node.children, string, index+1)
      end
    else
      [nil, index]
    end
  end

  def insert_word(word, definition)
    @num_words += 1
    last_node, index = self.find_last_child(@root.children, word, 0)
    if last_node == nil
      if index == 0
        last_available_node = @root
      else
        last_available_node, index2 = self.find_last_child(@root.children, word[0...index], 0)
      end
      parent_node = last_available_node
      word[index...word.length].chars.each do |letter|
        @num_letters += 1
        new_node = LetterNode.new(letter)
        new_node.parent = parent_node
        parent_node.children << new_node
        parent_node = new_node
      end
      parent_node.definition = definition
    else
      last_node.definition = definition
    end
  end

  def remove_word(word)
    last_node, index = self.find_last_child(@root.children, word, 0)
    if last_node
      last_node.definition = nil
      @num_words -= 1
      current_node = last_node
      word.length.times do |i|
        if current_node.children.length > 0 || current_node.definition
          return
        else 
          if i == word.length - 1
            parent_node = @root
          else
            parent_node, index2 = self.find_last_child(@root.children, word[0...word.length-i-1], 0)
          end
          parent_node.children.delete(current_node)
          @num_letters -=1
          current_node = parent_node
        end
      end
    end
  end

  def depth
    def max_depth(node, depth)
      depths = node.children.map do |node|
        max_depth(node, depth + 1)
      end

      depths << depth
      depths.max
    end

    max_depth(@root, 0)
  end
end


#Former Attempt

# def initialize(array = [])
#     @root = LetterNode.new(nil)
#     @num_words = 0
#     @num_letters = 0
#     @depth = 0
#     array.each do |word_array|
#       self.insert_word(word_array[0],word_array[1])
#     end


#     # if array.is_a? DictionaryTree
#     # end

#     # @root.letter = nil
#     #prepopulated_tree.definition

#   end

#   def insert_word(word, definition)
#     @num_words += 1
#     @num_letters += word.length
#     @depth = word.length
#     parent = @root
#     word.chars.each do |letter|
#      new_node = LetterNode.new(letter, parent)
#         #parent.children << new_node
#     end

#   end

#   def remove_word(word)
#     @num_words -= 1
#     @depth -= 1
#   end

#   def definition_of(word)
#     #word
#   end


# Sunday 
# def definition_of(string)
#     if root_node.children
#       root_node.word.chars.each do |letter|
#         new_node = LetterNode.new(letter, parent)

#         LetterNode = Struct.new(:letter, :definition, :children, :parent, :depth)
#         tree << new_node
#       end

#       #returns string definition
#     end

#     tree.each do |letter|
#       if letter.children && !tree.include? (letter.children)
#         new_node = LetterNode.new(letter, parent)
#         tree << new_node
#       end
#     end