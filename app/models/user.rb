class User < ApplicationRecord
  has_many :meetings
  has_many :talks
  has_many :favorites
  has_many :favorite_talks, through: :favorites, source: :talk
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :followed_users, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :username, presence: true
  validates :bio, length: { maximum: 65 }

  scope :speaker, -> { where('talks_count > 0') }

  strip_attributes

  def full_name
    "#{first_name} #{last_name}"
  end

  def follow!(user)
    active_relationships.create!(followed: user)
  end

  def unfollow!(user)
    active_relationships.find_by(followed: user).destroy
  end

  def following?(user)
    followed_users.include? user
  end

  def favorite?(talk)
    favorites.exists?(talk: talk)
  end

  def favorite!(talk)
    favorites.create!(talk: talk)
  end

  def unfavorite!(talk)
    favorites.find_by(talk: talk).destroy
  end

  def speaker?
    talks.any?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.bio = auth.info.description
      user.avatar_url = auth.extra.raw_info.avatar_url
      user.oauth_token = auth.credentials.token
    end
  end
end
