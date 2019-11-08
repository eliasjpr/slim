ENV["CRYSTAL_ENV"] = "spec"

require "spec"
require "../src/app"
require "./helpers"

Clear::Migration::Manager.instance.apply_all
