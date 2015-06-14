module UsersHelper

	# メールアドレスを画像を紐づける。(http://gravatar.com/)
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase) # メールアドレスを暗号化
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
