ENV["CRYSTAL_ENV"] = "spec"

require "spec"
require "../src/app"
require "./helpers"

Clear.logger = Logger.new(nil)
Clear::Migration::Manager.instance.apply_all
