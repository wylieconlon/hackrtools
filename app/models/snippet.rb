class Snippet < ActiveRecord::Base
  validates_presence_of :description, :code
  validates :description, :length => { :maximum => 140 }

end
