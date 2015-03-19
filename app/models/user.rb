class User < ActiveRecord::Base
  include BCrypt
  # Remember to create a migration!
  has_many :whispers

  has_many :stalker_relationships, class_name: "Stalking",
    foreign_key: "stalkee_id"
  has_many :stalkee_relationships, class_name: "Stalking",
    foreign_key: "stalker_id"

  has_many :stalkers, through: :stalker_relationships, source: "stalker"
  has_many :stalkees, through: :stalkee_relationships, source: "stalkee"

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
