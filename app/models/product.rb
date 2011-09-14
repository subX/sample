class Product < ActiveRecord::Base

		validates_presence_of :name, :description, :image_url, :price
		validates_uniqueness_of :name, :image_url
		validates :price, :numericality => {:greater_than => 0, :only_integer=>true}

end
