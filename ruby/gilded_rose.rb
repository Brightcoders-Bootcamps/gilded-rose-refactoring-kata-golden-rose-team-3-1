# frozen_string_literal: true

# clase Gilded Rose
class GildedRose
  
  def initialize(items)
    @items = items
    @goods = {  aged: 'Aged Brie',
                backstage: 'Backstage passes to a TAFKAL80ETC concert',
                sulfuras: 'Sulfuras, Hand of Ragnaros' }
  end

  
  def update_sell_in(item)
    name = item.name
    return unless name != @goods[:sulfuras]

    item.sell_in -= 1
  end

  def outlier_sell_in(item)
    quality = item.quality
    return unless item.sell_in.negative?

    if item.name != @goods[:aged]
      detect_backstage(item)
    elsif quality < 50
      item.quality += 1
    end
  end

  def detect_backstage(item)
    item.name != @goods[:backstage] ? item.decrease_quality : item.quality -= item.quality
  end

  def decrease_quality(item)
    quality = item.quality
    return unless quality.positive? && item.name != @goods[:sulfuras]

    item.quality -= 1
  end

  def define_quality(item)
    name = item.name
    if name != @goods[:aged] && name != @goods[:backstage]
      decrease_quality(item)
    else
      increase_quality(item)
    end
  end

  def increase_quality(item)
    return unless item.quality < 50

    item.quality += 1
    return unless item.name == @goods[:backstage]

    sell_in = item.sell_in
    increase_backstage(item) if sell_in < 11
    increase_backstage(item) if sell_in < 6
  end

  def increase_backstage(item)
    return unless item.quality < 50

    item.quality += 1
  end

  def init_proccess
    @items.each do |item|
      define_quality(item)
      update_sell_in(item)
      outlier_sell_in(item)
    end
  end
end


# Clase Items, no modificar
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

module ItemDecorator 
  def decrease_quality
    return unless @quality.positive? && @name != 'Sulfuras, Hand of Ragnaros'

    @quality -= 1
  end
end

Item.prepend ItemDecorator