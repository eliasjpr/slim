Clear.enum BalanceTransactionTypes,
  :Adjustment,
  :AppliedToInvoice,
  :CreditNote,
  :Initial,
  :InvoiceTooSmall,
  :InvoiceTooLarge,
  :UnspentReceiverCredit

Clear.enum BalanceTransactionStatusType, :Available, :Pending

class BalanceTransaction
  include Clear::Model

  belongs_to credit_note : CreditNote

  column id : Int64, primary: true, presence: false
  column customer_id : Int64
  column invoice_id : Int64
  column amount : Float64 = 0.0
  column ending_balance : Float64 = 0.0
  column type : BalanceTransactionTypes
  column status : BalanceTransactionStatusType
  column currency : String
  column description : String?
end
