module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
<<<<<<< HEAD
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
=======
>>>>>>> 716331d71dde278e0649d55e742667f7a3f35571
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.first_name, class: "gravatar")
  end
end