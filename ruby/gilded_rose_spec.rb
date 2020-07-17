# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.shared_examples 'common variables tests' do |values|
  let(:params) { values }

  it do
    items = [Item.new(params[0], params[1], params[2])]
    GildedRose.new(items).init_proccess
    
    expect(items.first.name).to eq params[0]
    expect(items.first.sell_in).to eq params[3]
    expect(items.first.quality).to eq params[4]
  end
end

RSpec.describe GildedRose do
  describe '#init_proccess' do
    context 'When sell_in is positive' do

      context 'and item Aged Brie' do
        include_examples 'common variables tests', ['Aged Brie', 10, 20, 9, 21]
      end

      context 'and item is Sulfuras' do
        include_examples 'common variables tests', ['Sulfuras, Hand of Ragnaros', 0, 80, 0, 80]
      end

      context 'and item is Backstage' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', 15, 20, 14, 21]
      end

      context 'and item is any other item' do
        include_examples 'common variables tests', ['+5 Dexterity Vest', 10, 20, 9, 19]
      end
    end

    context 'When sell_in is zero' do
      context 'and item is Aged Brie' do
        include_examples 'common variables tests', ['Aged Brie', 0, 20, -1 , 22]
      end

      context 'and item is Sulfuras' do
        include_examples 'common variables tests', ['Sulfuras, Hand of Ragnaros', 0, 80, 0, 80]
      end
      
      context 'and item is Backstage' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', 0, 20, -1, 0]
      end

      context 'And item is any other item' do
        include_examples 'common variables tests', ['+5 Dexterity Vest', 0, 20, -1, 18]
      end
    end

    context 'When sell_in is either 10 or bigger than 5' do
      context 'and item is Backstage passes' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', 10, 10, 9, 12]
      end
    end

    context 'When sell_in is either 5 or bigger than 0' do
      context 'and item is Backstage passes' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', 5, 3, 4, 6]
      end
    end

    context 'When quality is 0 and sell_in is negative' do
      context 'and item is Backstage passes' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', -1, 0, -2, 0]
      end
    
      context 'an item is Aged Brie' do
        include_examples 'common variables tests', ['Aged Brie', -1, 0, -2, 2]
      end

      context 'an item is any other item' do
        include_examples 'common variables tests', ['+5 Dexterity Vest', -1, 0, -2, 0]
      end
    end

    context 'When quality is 50' do
      context 'and item is Backstage passes' do
        include_examples 'common variables tests', ['Backstage passes to a TAFKAL80ETC concert', 21, 50, 20, 50]
      end
      
      context 'and item is Aged Brie' do
        include_examples 'common variables tests', ['Aged Brie', 3, 50, 2, 50]
      end
      
      context 'and item is any other Vest' do
        include_examples 'common variables tests', ['+5 Dexterity Vest', 5, 50, 4, 49]
      end
    end

    context 'When item is Conjured' do
      context 'and quality is 50' do
        include_examples 'common variables tests', ['Conjured', 21, 50, 20, 48]
      end
      
      context 'and quality is 0' do
        include_examples 'common variables tests', ['Conjured', 3, 0, 2, 0]
      end
      
      context 'and sell_in is valid' do
        include_examples 'common variables tests', ['Conjured', 5, 20, 4, 18]
      end
      
      context 'and sell_in is zero' do
        include_examples 'common variables tests', ['Conjured', 0, 2, -1, 0]
      end
      
      context 'and sell_in is invalid' do
        include_examples 'common variables tests', ['Conjured', -5, 4, -6, 2]
      end
    end
  end
end
