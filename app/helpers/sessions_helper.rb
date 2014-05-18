module SessionsHelper
	# Chapter 8 - Check back especially on the def current_user=(user) method
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		# ||= operator says if @current_user is nil, hit the database and fetch, but once it is no longer nil we no longer have to hit the database
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
end
