class Snippet < Item
  attr_accessible :code
  validates_presence_of :code
end
