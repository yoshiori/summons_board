require 'spec_helper'

describe SummonsBoard::Event do

  describe "#events" do
    let(:uid0) { SummonsBoard::Event.new(uid: "000000000") }
    let(:uid4) { SummonsBoard::Event.new(uid: "000000400") }

    it "uid 0 is AM 8:00 start" do
      expect(
        uid0.schedule(target: DateTime.new(2014,2,27))
      ).to eq times: [
        DateTime.new(2014,2,27,8)...DateTime.new(2014,2,27,9),
        DateTime.new(2014,2,27,13)...DateTime.new(2014,2,27,14),
        DateTime.new(2014,2,27,18)...DateTime.new(2014,2,27,19),
      ]
    end

    it "uid 4 is PM 12:00 start" do
      expect(
        uid4.schedule(target: DateTime.new(2014,2,27))
      ).to eq times: [
        DateTime.new(2014,2,27,12)...DateTime.new(2014,2,27,13),
        DateTime.new(2014,2,27,17)...DateTime.new(2014,2,27,18),
        DateTime.new(2014,2,27,22)...DateTime.new(2014,2,27,23),
      ]
    end
  end

  describe "#active?" do
    let(:uid0) { SummonsBoard::Event.new(uid: "000000000") }

    it "uid 0 is active at 2014/2/27 8:00" do
      expect(uid0.active?(target: DateTime.new(2014,2,27,8))).to be_true
    end

    it "uid 0 is not active at 2014/2/27 9:00" do
      expect(uid0.active?(target: DateTime.new(2014,2,27,9))).to be_false
    end
  end
end
