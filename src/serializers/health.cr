module Serializers
  struct Health
    include Onyx::HTTP::View

    json data: {
      status:      "pass",
      app_name:    "Slim",
      version:     "0.1.0",
      cpu_count:   System.cpu_count,
      hostname:    System.hostname,
      environment: ENV["CRYSTAL_ENV"],
      host:        ENV["HOST"],
      port:        ENV["PORT"],
      time:        Time.local,
    }
  end
end
