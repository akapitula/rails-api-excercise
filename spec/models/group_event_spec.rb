require 'rails_helper'

describe GroupEvent do

  describe "#mark_as_deleted!" do
    it "set to true and update the :deleted attribute" do
      ge = create(:group_event)
      expect { ge.mark_as_deleted }.to change{ ge.deleted }.from(false).to(true)
    end
  end

  describe "#format_attributes" do
    context "with attributes :starts_on and :ends_on" do
      it "calculates :duration" do
        ge = build(:group_event, starts_on: Date.today, ends_on: Date.today + 15)
        ge.save
        expect(ge.duration).to eq(15)
      end
    end
    context "with attributes :starts_on and :duration" do
      it "calculates :ends_on" do
        ge = build(:group_event, starts_on: Date.today, duration: 30, ends_on: nil)
        ge.save
        expect(ge.ends_on).to eq(Date.today + 30)
      end
    end

    context "with attributes :duration and :ends_on" do
      it "calculate and set the :starts_on attribute" do
        ge = build(:group_event, duration: 60, ends_on: Date.today + 60, starts_on: nil)
        ge.save
        expect(ge.starts_on).to eq(Date.today)
      end
    end
  end

  describe "#any_attribute_present" do
    it "at least one attribute present" do
      ge = GroupEvent.new
      ge.valid?
      expect(ge.errors[:base]).to include("specify at least one base attribute")
    end
  end

  describe "#all_attributes_present?" do
    context "all the attributes present" do
      it "returns true" do
        ge = create(:group_event)
        expect(ge.send('all_attributes_present?')).to be_truthy
      end
    end
  end
end
