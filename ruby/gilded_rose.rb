# frozen_string_literal: true

# clase Gilded Rose
class GildedRose

  def initialize(items)
    @items = items
    @goods = { :aged => 'Aged Brie',
                  :backstage => 'Backstage passes to a TAFKAL80ETC concert',
                  :sulfuras => 'Sulfuras, Hand of Ragnaros' }
  end

  def update_sell_in(item)
    return unless item.name != @goods[:sulfuras]

    item.sell_in = item.sell_in - 1
  end

  def outlier_sell_in(item)
    return unless item.sell_in.negative?

    item.name != @goods[:aged] ? detect_backstage(item) : item.quality += 1 if item.quality < 50
  end

  def detect_backstage(item)
    item.name != @goods[:backstage] ? decrease_quality(item) : item.quality -= item.quality
  end

  def decrease_quality(item)
    return unless item.quality.positive? && item.name != @goods[:sulfuras]

    item.quality -= 1
  end

  def define_quality(item)
    if item.name != @goods[:aged] && item.name != @goods[:backstage]
      decrease_quality(item)
    else
      increase_quality(item)
    end
  end

  def increase_quality(item)
    return unless item.quality < 50

    item.quality += 1
    return unless item.name == @goods[:backstage]

    increase_backstage(item) if item.sell_in < 11
    increase_backstage(item) if item.sell_in < 6
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

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
