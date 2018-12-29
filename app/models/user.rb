class User < ActiveRecord::Base

  has_secure_password

  has_many :cards
  has_many :decks

end
