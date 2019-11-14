require "./spec_helper"
require "../../../src/domain/coupon.cr"

describe Coupon do
  coupon = build_coupon(amount: 3.00)

  describe "#deduction_for" do
    it "returns amount off when value is present" do
      coupon.deduction_for(10.00).should eq 3.00
    end

    it "returns percent off when value is present" do
      coupon.amount_off = nil
      coupon.percent_off = 0.30
      coupon.deduction_for(10.00).should eq 3.00
    end

    it "returns 0 when amount and percent off is nil" do
      coupon.amount_off = nil
      coupon.percent_off = nil
      coupon.deduction_for(10.00).should eq 0.00
    end
  end

  describe "#applicable?" do
    it "rerturns true redeem_by is in the future" do
      coupon.redeem_by = 5.months.from_now
      coupon.applicable?.should be_truthy
    end

    it "rerturns false redeem_by is in the past" do
      coupon.redeem_by = 5.months.ago
      coupon.applicable?.should be_falsey
    end
  end

  describe "#redeemable?" do
    it "returns true when max redemptions is greater than times redeemed" do
      coupon.max_redemptions = 1
      coupon.times_redeemed = 0
      coupon.redeemable?.should be_truthy
    end

    it "returns false when max redemptions is reached" do
      coupon.times_redeemed = 1
      coupon.redeemable?.should be_falsey
    end
  end

  describe "#redeem!" do
    it "increments @times_redeemed" do
      clear
      subject = create_coupon

      subject.redeem!

      subject.times_redeemed.should eq 1
    end
  end
end
