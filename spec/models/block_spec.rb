require 'rails_helper'

RSpec.describe Block, type: :model do
  it { should belong_to :mobilization }
  it { should have_many :widgets }
  it { should validate_presence_of :mobilization_id }
  it { should validate_presence_of :position }
  it { should accept_nested_attributes_for :widgets }

  describe "#set_position" do
    it "should set the block's position to the maximum position + 1" do
      mobilization1 = Mobilization.make!
      mobilization2 = Mobilization.make!
      block1 = Block.make! mobilization: mobilization1
      block2 = Block.make! mobilization: mobilization1
      block3 = Block.make! mobilization: mobilization2
      block4 = Block.make! mobilization: mobilization2, position: 123
      block5 = Block.make! mobilization: mobilization2
      expect(block1.position).to eq 1
      expect(block2.position).to eq 2
      expect(block3.position).to eq 1
      expect(block4.position).to eq 123
      expect(block5.position).to eq 124
    end
  end

  describe "#switch_positions" do
    it "should change positions when moving blocks up and down" do
      mobilization = Mobilization.make!
      block1 = Block.make! mobilization: mobilization
      block2 = Block.make! mobilization: mobilization

      expect { block1.update position: 2 }.to change { block1.reload.position }.to 2
      expect(block2.reload.position).to eq 1
      expect { block2.update position: 2 }.to change { block2.reload.position }.to 2
      expect(block1.reload.position).to eq 1
    end
  end
end
