module Ruml
  def self.broadcast!(name, input)
    ml = Ruml::List.new(name)
    Ruml::Broadcaster.new(ml, input).broadcast!
  end
end

require 'ruml/list'
require 'ruml/config'
require 'ruml/broadcaster'
require 'ruml/version'
