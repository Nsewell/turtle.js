require 'rubygems'
require 'dm-core'
require 'dm-postgres-adapter'
require 'dm-migrations'

DataMapper.setup(:default, 'postgres://aronzak@localhost/papert')

class Users
  include DataMapper::Resource

  property :id,			Serial
end

class Saves
  include DataMapper::Resource

	property :id,		 Serial
	property :user,  Integer
  property :img,   Text
  property :code,  Text
end

DataMapper.finalize
#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!
