ENV["CRYSTAL_ENV"] = "test"

require "spec"
require "../src/app"
require "./helpers"

Clear::Migration::Manager.instance.apply_all
