require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "secret"
	end

	get '/' do
		erb :index
	end

	get '/signup' do
		erb :'/users/signup'
	end
	
	post '/signup' do
	#	raise params.inspect
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		@session = session
		@session[:user_id] = @user.id
		if logged_in? && !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
			redirect '/parts/index'
		else
			redirect '/signup'
		end
	end

	get '/login' do
		erb :'users/login'
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			@session = session
			@session[:user_id] = @user.id
			redirect '/parts/index'
		else
			erb :'/users/login'
		end
	end

	get	'/parts/index' do
		@user = current_user
		@parts = @user.parts
		erb :'/parts/index'
	end

	get '/logout' do
    	session.delete(:user_id)
    	redirect '/login'
	end

	helpers do
	    def logged_in?
	      !!session[:user_id]
	    end

	    def current_user
	      User.find(session[:user_id])
	    end
  	end
end