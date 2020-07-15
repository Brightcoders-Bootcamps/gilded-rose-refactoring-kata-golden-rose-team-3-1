# frozen_string_literal: true

$goods = { aged: "Aged Brie",
           backstage: "Backstage passes to a TAFKAL80ETC concert",
           sulfuras: "Sulfuras, Hand of Ragnaros" }

# clase Gilded Rose
class GildedRose
  def initialize(items)
    @items = items
  end

  def init_proccess
    @items.each do |item|
      item.define_quality
      item.update_sell_in
      item.outlier_sell_in
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
  def decrease_quality
    return unless @quality.positive? && @name != $goods[:sulfuras]

    @quality -= 1
  end

  def update_sell_in
    return unless @name != $goods[:sulfuras]

    @sell_in -= 1
  end

  def outlier_sell_in
    return unless @sell_in.negative?

    if @name != $goods[:aged]
      detect_backstage
    elsif @quality < 50
      @quality += 1
    end
  end

  def detect_backstage
    @name != $goods[:backstage] ? decrease_quality : @quality -= @quality
  end

  def define_quality
    if @name != $goods[:aged] && @name != $goods[:backstage]
      decrease_quality
    else
      increase_quality
    end
  end

  def increase_quality
    return unless @quality < 50

    @quality += 1
    return unless @name == $goods[:backstage]

    increase_backstage if @sell_in < 11
    increase_backstage if @sell_in < 6
  end

  def increase_backstage
    return unless @quality < 50

    @quality += 1
  end
end

Item.prepend ItemDecorator
