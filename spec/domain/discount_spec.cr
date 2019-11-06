require "./spec_helper"
require "../../src/domain/discount.cr"

describe Discount do
  subscription = build_subscription

  describe "triggers" do
    context "before create" do
      it "creates discount if coupon is applicable" do
        clear
        subscription.save
        coupon = build_coupon(ends_on: 2.day.from_now)
        discount = build_discount(coupon, subscription, starts_on: Time.local)

        discount.save

        discount.valid?.should be_truthy
        discount.persisted?.should be_truthy
      end

      it "does not create a discount if coupon is not applicable" do
        coupon = build_coupon(ends_on: 2.day.ago)
        discount = build_discount(coupon, subscription, starts_on: Time.local)
        discount.save

        discount.valid?.should be_falsey
        discount.persisted?.should be_falsey
      end
    end
  end

  describe "#expired?" do
    it "returns true for expired discount" do
      coupon = build_coupon(amount: 3.00)
      subject = build_discount(coupon, subscription, starts_on: 1.month.ago)

      subject.expired?.should be_truthy
    end

    it "returns false for a discount that has not expired" do
      coupon = build_coupon(amount: 3.00)
      subject = build_discount(coupon, subscription)

      subject.expired?.should be_falsey
    end
  end

  describe "#valid?" do
    it "returns false when coupon cannot be redeemed is invalid" do
      coupon = build_coupon(redemptions: 1, times_redeemed: 1)
      subject = build_discount(coupon, subscription, 1, Time.local)

      subject.valid?.should be_falsey
    end

    it "returns false when discount has expired" do
      coupon = build_coupon(redemptions: 2)
      subject = build_discount(coupon, subscription, starts_on: 3.month.ago)

      subject.valid?.should be_falsey
    end

    it "returns false when coupon has expired" do
      coupon = build_coupon(redemptions: 2, ends_on: 3.days.ago)
      subject = build_discount(coupon, subscription, starts_on: 3.month.from_now)

      subject.valid?.should be_falsey
    end

    it "returns true when discount has not expired and coupon is valid" do
      coupon = build_coupon(redemptions: 5)
      subject = build_discount(coupon, subscription, starts_on: 1.month.from_now)

      subject.valid?.should be_truthy
    end
  end

  describe "#amount_for" do
    describe "calculates discounted amount" do
      context "when discount is no longer valid" do
        it "returns 0.00" do
          coupon = build_coupon(redemptions: 1, duration: CouponDuration::Forever)
          discount = build_discount(coupon, subscription, starts_on: 2.month.ago)

          discount.amount_for(10.00).should eq 0.00
        end
      end

      context "when coupon duration is forever" do
        it "always returns a discount amount" do
          coupon = build_coupon(redemptions: 1, duration: CouponDuration::Forever)
          discount = build_discount(coupon, subscription, starts_on: Time.local)

          discount.amount_for(10.00).should eq 1.00
          discount.amount_for(10.00).should eq 1.00
        end
      end

      context "when coupon duration is once" do
        it "only calculates amount once" do
          subscription = build_subscription(id: 3)
          coupon = build_coupon(redemptions: 1, duration: CouponDuration::Forever)
          discount = build_discount(coupon, subscription, starts_on: Time.local)

          discount.amount_for(10.00).should eq 1.00
          discount.redeem!
          discount.amount_for(10.00).should eq 0.00
        end
      end

      context "when coupon duration is repeating" do
        it "calculates amount repeadedly until discount expires" do
          coupon = build_coupon(redemptions: 10, duration: CouponDuration::Forever)
          discount = build_discount(coupon, subscription, starts_on: Time.local)

          discount.amount_for(10.00).should eq 1.00
          discount.starts_on = 2.months.ago
          discount.amount_for(10.00).should eq 0.00
        end
      end
    end
  end
end
