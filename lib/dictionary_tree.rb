require 'letter_node'

class DictionaryTree

  attr_reader :root, :num_words, :num_letters, :depth

  def initialize(array = [])
    @root = LetterNode.new(nil)
    @num_words = 0
    @num_letters = 0
    @depth = 0
    array.each do |word_array|
      self.insert_word(word_array[0],word_array[1])
    end


    # if array.is_a? DictionaryTree
    # end

    # @root.letter = nil
    #prepopulated_tree.definition

  end

  def insert_word(word, definition)
    @num_words += 1
    @num_letters += word.length
    @depth = word.length
    parent = @root
    word.chars.each do |letter|
     new_node = LetterNode.new(letter, parent)
        #parent.children << new_node
    end

  end

  def remove_word(word)
    @num_words -= 1
    @depth -= 1
  end

  def definition_of(word)
    #word
  end

 


end