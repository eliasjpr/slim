@[HTTP::Params::Serializable::Scalar]
struct Converters::Date
  def self.to_http_param(value : Time, builder : HTTP::Params::Builder, key : String)
    builder.add(key, to_http_param(value))
  end

  # Return `self` as an HTTP param string.
  def self.to_http_param(value : Time)
    value.to_s
  end

  # Parse `URI` from an HTTP param.
  def self.from_http_param(value : String)
    new(Time.parse(value, "%m-%d-%Y", Time::Location::UTC))
  end

  def self.from_http_param(value : String, path : Tuple(String))
    new(Time.parse(value, "%m-%d-%Y", Time::Location::UTC))
  end

  getter value : Time

  def initialize(@value : Time)
  end
end
