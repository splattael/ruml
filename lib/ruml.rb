require 'mail'
require 'moneta'
require 'moneta/adapters/basic_file'
require 'moneta/adapters/yaml'

module Ruml
  autoload :List,         'ruml/list'
  autoload :Config,       'ruml/config'
  autoload :Broadcaster,  'ruml/broadcaster'
  autoload :VERSION,      'ruml/version'

  def self.broadcast!(name, input)
    ml = Ruml::List.new(name)
    Ruml::Broadcaster.new(ml, input).broadcast!
  end
end
