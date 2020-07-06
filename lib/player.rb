class Player
  attr_reader :name
  attr_accessor :marker
  attr_accessor :position

  def initialize(name, marker = "", position = "")
    @name = name
    @marker = marker
    @position = position
  end
end