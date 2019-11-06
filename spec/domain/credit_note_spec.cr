require "./spec_helper"
require "../../src/domain/credit_note.cr"

describe CreditNote do
  customer_id = 1_i64
  start_date = Time.utc
  billing_period = BillingPeriod.new(start_date, 1.month)

  it "gets a sum of all credits for date range" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    CreditNote.credits_for(customer_id, billing_period).should eq 14.65
  end

  it "only sums issued credits" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    create_credit_note(1, 10, CreditNoteStatus::Void)
    CreditNote.credits_for(customer_id, billing_period).should eq 14.65
  end

  it "returns 0.0 when there is not credits available" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    billing_period = BillingPeriod.new(start_date, -1.day)
    CreditNote.credits_for(customer_id, billing_period).should eq 0.00
  end
end
