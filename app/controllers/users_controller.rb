class UsersController < ApplicationController
	get '/signup' do
		erb :'/users/signup'
	end
	
	post '/signup' do
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		if @user.valid?
			@user.save

			redirect '/parts/index'

		else
			render :signup
		end
#		errors = Hash.new
#		
#		if params[:username].empty?
#			errors[:username] = "Username should not be blank"
#		elsif User.find_by(username: params[:username])
#			errors[:username] = "Username is already taken"
#		end
#
#		if params[:email].empty?
#			errors[:email] = "Email should not be blank"
#		elsif User.find_by(email: params[:email])
#			errors[:email] = "Email is already being used"
#		end
#
#		if params[:password].empty?
#			errors[:password] = "Password should not be blank"
#		end
#
#		if errors.empty?
#			@user = User.create(username: params[:username], email: params[:email], password: params[:password])
#			redirect '/parts/index'
#		else
#			flash[:message] = errors
#			redirect '/signup'
#		end
	end

	get '/login' do
		erb :'users/login'
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/parts/index'
		else
			 flash[:message] = "That username and/or password did not match what we have on record. Please try again."
			erb :'/users/login'
		end
	end

	get '/logout' do
    	session.delete(:user_id)
    	redirect '/login'
	end
end


