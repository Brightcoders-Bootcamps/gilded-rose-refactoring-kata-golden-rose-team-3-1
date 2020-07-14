require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#init_proccess" do
    context 'When sell_in is positive' do
      it 'and item is Aged Brie' do
        items = [Item.new('Aged Brie', 10, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Aged Brie'
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 21
      end

      it 'and item is Sulfuras' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Sulfuras, Hand of Ragnaros'
        expect(items[0].sell_in).to be_zero
        expect(items[0].quality).to eq 80
      end

      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq 14
        expect(items[0].quality).to eq 21
      end

      it 'and item is any other item' do
        items = [Item.new('+5 Dexterity Vest', 10, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq '+5 Dexterity Vest'
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 19
      end
    end

    context 'When sell_in is zero' do
      it 'and item is Aged Brie' do
        items = [Item.new('Aged Brie', 0, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Aged Brie'
        expect(items[0].sell_in).to eq(-1)
        expect(items[0].quality).to eq 22
      end

      it 'and item is Sulfuras' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Sulfuras, Hand of Ragnaros'
        expect(items[0].sell_in).to be_zero
        expect(items[0].quality).to eq 80
      end

      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq(-1)
        expect(items[0].quality).to eq 0
      end

      it 'and item is any other item' do
        items = [Item.new('+5 Dexterity Vest', 0, 20)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq '+5 Dexterity Vest'
        expect(items[0].sell_in).to eq(-1)
        expect(items[0].quality).to eq 18
      end
    end

    context 'When sell_in is either 10 or bigger than 5' do
      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 12
      end
    end

    context 'When sell_in is either 5 or bigger than 0' do
      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 3)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 6
      end
    end

    context 'When quality is 0 and sell_in is negative' do
      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', -1, 0)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq(-2)
        expect(items[0].quality).to eq 0
      end

      it 'and item is Aged Brie' do
        items = [Item.new('Aged Brie', -1, 0)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Aged Brie'
        expect(items[0].sell_in).to eq(-2)
        expect(items[0].quality).to eq 2
      end

      it 'and item is +5 Dexterity Vest' do
        items = [Item.new('+5 Dexterity Vest', -1, 0)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq '+5 Dexterity Vest'
        expect(items[0].sell_in).to eq(-2)
        expect(items[0].quality).to eq 0
      end
    end

    context 'When quality is 50' do
      it 'and item is Backstage passes' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 21, 50)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Backstage passes to a TAFKAL80ETC concert'
        expect(items[0].sell_in).to eq 20
        expect(items[0].quality).to eq 50
      end

      it 'and item is Aged Brie' do
        items = [Item.new('Aged Brie', 3, 50)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq 'Aged Brie'
        expect(items[0].sell_in).to eq 2
        expect(items[0].quality).to eq 50
      end

      it 'and item is +5 Dexterity Vest' do
        items = [Item.new('+5 Dexterity Vest', 5, 50)]
        GildedRose.new(items).init_proccess()

        expect(items[0].name).to eq '+5 Dexterity Vest'
        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 49
      end
    end
  end
end
