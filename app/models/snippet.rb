class Snippet < ActiveRecord::Base
  validates_presence_of :title, :code
  validates :title, :length => { :maximum => 140 }

end
