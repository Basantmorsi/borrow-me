module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.username
    opts[:width] = "60px"
    image_tag "https://logowik.com/content/uploads/images/chat8883.jpg",
              opts
  end
end
