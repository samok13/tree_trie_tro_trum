

LetterNode = Struct.new :letter, :definition, :children, :parent, :depth do

  def initialize(*)
    super
    self.children ||= []
  end
end

