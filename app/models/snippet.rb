class Snippet < ActiveRecord::Base
  validates_presence_of :title, :code
  validates :title, :length => { :maximum => 140 }
  has_and_belongs_to_many :tags
  belongs_to :user
end
