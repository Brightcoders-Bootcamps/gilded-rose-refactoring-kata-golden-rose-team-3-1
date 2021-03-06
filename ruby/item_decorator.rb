# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'item')

GOODS = { aged: 'Aged Brie',
          backstage: 'Backstage passes to a TAFKAL80ETC concert',
          sulfuras: 'Sulfuras, Hand of Ragnaros',
          conjured: 'Conjured' }.freeze

# Decorator of Item class
module ItemDecorator
  def update_quality
    return if invalid_quality? || sulfuras_item?

    @quality += calculate_quality_value
    round_quality
  end

  def invalid_quality?
    @quality.negative? || @quality > 50
  end

  def aged_brie_item?
    @name == GOODS[:aged]
  end

  def sulfuras_item?
    @name == GOODS[:sulfuras]
  end

  def backstage_item?
    @name == GOODS[:backstage]
  end

  def conjured_item?
    @name.start_with?(GOODS[:conjured])
  end

  def special_item?
    GOODS.key?(retrieve_name)
  end

  def calculate_quality_value
    return quality_aged_brie if aged_brie_item?
    return quality_backstage if backstage_item?

    quality_common_item
  end

  def retrieve_name
    @name.downcase.split.first
  end

  def quality_aged_brie
    return 2 if sell_in.negative?

    1
  end

  def quality_backstage
    return @quality * -1 if @sell_in <= 0
    return 2 if @sell_in < 11 && @sell_in > 5
    return 3 if @sell_in < 6

    1
  end

  def round_quality
    if @quality > 50
      @quality = 50
    elsif @quality.negative?
      @quality = 0
    end
  end

  def quality_common_item
    return -2 if @sell_in.negative? || conjured_item?

    -1
  end

  def update_sell_in
    return if sulfuras_item?

    @sell_in -= 1
  end
end

Item.prepend ItemDecorator
