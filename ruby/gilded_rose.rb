# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'item_decorator')

# clase Gilded Rose
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality(item)
    item.update_quality
  end

  def init_proccess
    @items.each do |item|
      item.update_sell_in
      update_quality(item)
    end
  end
end
