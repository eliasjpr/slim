module Errors
  class NotFound < Onyx::HTTP::Error(404)
    def initialize(@id : Int64, @type : String)
      super("Subscription not found with this id")
    end

    def payload
      {id: @id, type: @type}
    end
  end

  class BadRequest < Onyx::HTTP::Error(400)
    def initialize(@type : String, message : String?, @errors : String? = nil)
      super(message)
    end

    def payload
      {type: @type, errors: @errors}
    end
  end
end
