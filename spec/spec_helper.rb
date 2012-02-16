require 'rubygems'
require 'bundler'

require 'mongoid'
models_folder = File.join(File.dirname(__FILE__), 'mongoid/models')

Mongoid.configure do |config|
  name = 'revisions_mongo_test'
  host = 'localhost'
  config.master = Mongo::Connection.new.db(name)
  config.autocreate_indexes = true
end

require 'mongoid_revisions'

Dir[ File.join(models_folder, '*.rb') ].each { |file|
  require file
  file_name = File.basename(file).sub('.rb', '')
  klass = file_name.classify.constantize
  klass.collection.drop unless klass.embedded?
}
