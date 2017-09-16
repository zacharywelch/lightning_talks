class Guest
  include ActiveModel::Model

  def id
    nil
  end

  def username
    nil
  end

  def admin?
    false
  end

  def following?(user)
    false
  end

  def active_relationships
    Relationship.none
  end
end
