Clear.enum CreditNoteStatus, :issued, :void
Clear.enum CreditNoteTypes, :post_payment, :pre_payment
Clear.enum CreditNoteReasons, :duplicate, :fraudulent, :order_change, :product_unsatisfactory

class CreditNote
  include Clear::Model

  column id : Int64, primary: true, presence: false
  column amount : Float64 = 0.0
  column customer_id : Int64
  column memo : String? = nil
  column reason : CreditNoteReasons
  column status : CreditNoteStatus
  column type : CreditNoteTypes
  column created_at : Time, presence: false

  def self.credits_for(id : Int32, start_date : Time, end_date : Time) : Float64
    query.where {
      (customer_id == id) &
        (status == CreditNoteStatus::Issued) &
        (created_at.in?(start_date..end_date))
    }.agg("SUM(amount)", Float64 | Nil) || 0.0
  end
end
