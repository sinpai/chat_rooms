module ApplicationHelper

    # Returns the Gravatar for the given user.
    def gravatar_for(email, options = { size: 42 })
      gravatar_id = Digest::MD5::hexdigest(email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
      image_tag(gravatar_url, alt: email, class: "gravatar")
    end

    def email_for(id)
      User.find(id).email
    end
end
