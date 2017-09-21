module UsersHelper

  def speaker_badge(user)
    if user.speaker?
      content_tag :span, 'speaker',
                  class: 'badge fill-lighten0 dark small pad1x round inline'
    end
  end

  def user_first_name(user)
    user.first_name || user.username
  end

  def user_full_name(user)
    user.full_name || user.username
  end
end
