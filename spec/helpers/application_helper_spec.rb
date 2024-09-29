require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_background_color' do
    it "returns 'bg-blue-300' for 'notice'" do
      expect(helper.flash_background_color('notice')).to eq('bg-blue-300')
    end

    it "returns 'bg-orange-200' for 'alert'" do
        expect(helper.flash_background_color('alert')).to eq('bg-orange-200')
    end

    it "returns 'bg-yellow-200' for 'error'" do
        expect(helper.flash_background_color('error')).to eq('bg-yellow-200')
    end

    it "returns 'bg-blue-300' for other types" do
        expect(helper.flash_background_color('other')).to eq('bg-blue-300')
    end
  end
end