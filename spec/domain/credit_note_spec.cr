require "./spec_helper"
require "../../src/domain/credit_note.cr"

describe CreditNote do
  customer_id = 1
  start_date = Time.parse("09-09-2019", "%m-%d-%Y", Time::Location::UTC)
  end_date = Time.utc.at_end_of_day

  it "gets a sum of all credits for date range" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    CreditNote.credits_for(customer_id, start_date, end_date).should eq 14.65
  end

  it "only sums issued credits" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    create_credit_note(1, 10, CreditNoteStatus::Void)
    CreditNote.credits_for(customer_id, start_date, end_date).should eq 14.65
  end

  it "returns 0.0 when there is not credits available" do
    clear
    create_credit_note(1, 9.85)
    create_credit_note(1, 1.15)
    create_credit_note(1, 3.65)
    end_date = 1.day.ago
    CreditNote.credits_for(customer_id, start_date, end_date).should eq 0.00
  end
end
