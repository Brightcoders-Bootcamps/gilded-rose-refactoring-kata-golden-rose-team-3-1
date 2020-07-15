# frozen_string_literal: true

GOODS = { aged: 'Aged Brie',
          backstage: 'Backstage passes to a TAFKAL80ETC concert',
          sulfuras: 'Sulfuras, Hand of Ragnaros' }.freeze

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

# Decorator of Item class
module ItemDecorator
  def update_quality
    return if invalid_quality? || sulfuras_item?

    @quality += calculate_quality_value
    round_quality
  end

  def invalid_quality?
    @quality <= 0 || @quality > 50
  end

  def sulfuras_item?
    @name == GOODS[:sulfuras]
  end

  def backstage_item?
    @name == GOODS[:backstage]
  end

  def calculate_quality_value
    if @sell_in.positive?
      increase_quality_value
    else
      decrease_quality_value
    end
  end

  def increase_quality_value
    if backstage_item?
      return 2 if @sell_in < 11 && @sell_in > 5
      return 3 if @sell_in < 6
    end
    1
  end

  def round_quality
    if @quality > 50
      @quality = 50
    elsif @quality.negative?
      @quality = 0
    end
  end

  def decrease_quality_value
    return @quality * -1 if backstage_item?

    -2
  end

  def update_sell_in
    return if sulfuras_item?

    @sell_in -= 1
  end
end

Item.prepend ItemDecorator
