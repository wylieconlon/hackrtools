class Snippet < ActiveRecord::Base
  validates_presence_of :title, :code
  validates :description, :length => { :maximum => 140 }

end
