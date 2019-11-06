require "./app"

# Boot server
Slim.listen(port: ENV["PORT"].to_i32)
