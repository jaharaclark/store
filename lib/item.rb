class Item
  attr_reader :name, :price
  
  def initialize(product)
    @name = product[:name]
    @price = product[:price].delete("$").to_f
  end
end