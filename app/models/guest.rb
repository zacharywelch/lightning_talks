class Guest
  include ActiveModel::Model

  def id
    nil
  end

  def username
    nil
  end

  def avatar_url
    Faker::Avatar.image
  end

  def admin?
    false
  end

  def following?(user)
    false
  end

  def favorite?(talk)
    false
  end

  def active_relationships
    Relationship.none
  end

  def favorites
    Favorite.none
  end
end
