class User < ActiveRecord::Base
  require 'digest'
  include BCrypt
  # Remember to create a migration!
  has_many :whispers

  has_many :stalker_relationships, class_name: "Stalking",
    foreign_key: "stalkee_id"
  has_many :stalkee_relationships, class_name: "Stalking",
    foreign_key: "stalker_id"

  has_many :stalkers, through: :stalker_relationships, source: "stalker"
  has_many :stalkees, through: :stalkee_relationships, source: "stalkee"

  validates :username, :email, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def stalking?(user)
    stalkees.include?(user)
  end

  def stalked_by?(user)
    stalkers.include?(user)
  end

  def stalk(user_to_stalk)
    if self.stalking?(user_to_stalk)
      p "you're already stalking #{user_to_stalk.username}!"
    else
      Stalking.create(stalker_id: self.id, stalkee_id: user_to_stalk.id)
    end
  end

  def unstalk(user_to_unstalk)
    if Stalking.where(stalker_id: self.id, stalkee_id: user_to_unstalk.id).first.destroy
    else
      p "failed to unstalk"
    end
  end

  def feed
    whisper_array = []
    self.stalkees.each do |stalkee|
      whisper_array << stalkee.whispers
    end
    whisper_array.flatten!
    whisper_array = whisper_array.sort_by {|whispers| whispers.created_at}
    whisper_array.reverse!
    # return whisper_array
    # binding.pry
  end

  def gravatar_url
    md5_hash = Digest::MD5.new
    md5_hash.update self.email
    return "http://www.gravatar.com/avatar/#{md5_hash}?d=http://cbsnews2.cbsistatic.com/hub/i/r/2002/08/05/da62eade-a642-11e2-a3f0-029118418759/thumbnail/620x350/d58085faadcad60fea4c167fee36a99a/image517488x.jpg"
  end

end
