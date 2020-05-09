class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password
  enum position: { user: 0, admin: 1 }
end
