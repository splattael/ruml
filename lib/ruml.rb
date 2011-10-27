require 'mail'

module Ruml
  autoload :List,         'ruml/list'
  autoload :Broadcaster,  'ruml/broadcaster'
  autoload :VERSION,      'ruml/version'

  def self.new(*args)
    List.new(*args)
  end
end
