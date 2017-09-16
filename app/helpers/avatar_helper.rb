module AvatarHelper

  def avatar_for(user, options = {})
    image_tag user.avatar_url, options.merge(alt: user.username)
  end
end
