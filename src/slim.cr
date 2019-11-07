require "./app"

# Boot server
Slim.listen(host: ENV["HOST"], port: ENV["PORT"].to_i32)
