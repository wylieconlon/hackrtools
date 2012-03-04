class Item < ActiveRecord::Base
  attr_accessible :title, :link, :public, :type

  def self.inherited(child)
    child.instance_eval do
      def model_name
        Item.model_name
      end
    end
    super
  end

  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end

end
