class Market
  attr_reader :name, :vendors
  
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    list = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each do |key|
        list << vendor if key == item
      end
    end
    list
  end

  def calculate_quantity(item)
    @vendors.sum do |vendor|
        vendor.inventory[item] 
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor| 
      vendor.inventory.each do |item, stock|
        inventory[item] = {quantity: calculate_quantity(item), vendors: vendors_that_sell(item)}
      end
    end
    inventory
  end

  def overstocked_items
    total_inventory.map do |item, value_hash|
    item if value_hash[:quantity] > 50 && value_hash[:vendors].length > 1
   end.compact
  end

   def sorted_item_list
   total_inventory.keys.map do |key|
    key.name
   end.sort
  end

  def date
    Date.today.strftime("%Y/%m/%d")
  end

  def sell(item, quantity)
    calculate_quantity(item) >= quantity
  end

  # def subtract_quantity(item, quantity)
  #    @vendors.sum do |vendor|
  #       vendor.inventory[item] - quantity
  #    end
  # end
end