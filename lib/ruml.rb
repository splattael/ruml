require 'mail'
require 'moneta'
require 'moneta/adapters/basic_file'
require 'moneta/adapters/yaml'

module Ruml
  autoload :List,         'ruml/list'
  autoload :Config,       'ruml/config'
  autoload :Broadcaster,  'ruml/broadcaster'
  autoload :VERSION,      'ruml/version'

  def self.new(*args)
    List.new(*args)
  end
end
