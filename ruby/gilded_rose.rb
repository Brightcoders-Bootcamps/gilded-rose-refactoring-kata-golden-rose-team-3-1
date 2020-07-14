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

  def negative_sell_in(item)
    if item.sell_in.negative?
      item.name != @goods[:aged] ? detect_backstage(item) : item.quality += 1 if item.quality < 50
    end
  end

  def detect_backstage(item)
    item.name != @goods[:backstage] ? detect_sulfuras(item) : item.quality = item.quality - item.quality
  end

  def detect_sulfuras(item)
    if item.quality.positive? && item.name != @goods[:sulfuras]
      item.quality -= 1
    end
  end

  def update_quality()
    @items.each do |item|
      if item.name != @goods[:aged] and item.name != @goods[:backstage]
        if item.quality.positive?
          if item.name != @goods[:sulfuras]
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == @goods[:backstage]
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      update_sell_in(item)
      negative_sell_in(item)
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
