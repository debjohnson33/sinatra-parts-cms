require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

use Rack::Flash

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
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		@session = session
		@session[:user_id] = @user.id
		if logged_in? && !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
			redirect '/parts/index'
		else
			flash[:message] = "You must have username, email, and password to sign up. Please fill in all three."
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

	get '/new' do
		erb :'/parts/new'
	end

	post '/new' do
		# raise params.inspect
		if params[:name].empty? || params[:serial_number].empty? || params[:quantity].empty? || params[:manufacturer].empty?
			redirect '/new'
		else
			@user = current_user
			@part = Part.new(name: params[:name], serial_number: params[:serial_number], quantity: params[:quantity], manufacturer: params[:manufacturer], user_id: session[:user_id])
			@part.save
			redirect '/parts/index'				
		end
	end

	get '/parts/:id' do
		if logged_in? && current_user
			@part = Part.find_by_id(params[:id])
			erb :'/parts/show'
		else
			redirect '/login'
		end
	end

	get '/parts/:id/edit' do
		@part = Part.find_by_id(params[:id])
		erb :'/parts/edit'
	end

	patch '/parts/:id' do
		if params[:name].empty? || params[:serial_number].empty? || params[:quantity].empty? || params[:manufacturer].empty?
			redirect '/parts/edit'
		else
			@part = Part.find_by_id(params[:id])
			@part.name = params[:name] 
			@part.serial_number = params[:serial_number]
			@part.quantity = params[:quantity]
			@part.manufacturer = params[:manufacturer]
			@part.save
			redirect "/parts/#{@part.id}"
		end
	end

	delete '/parts/:id' do
		if current_user
			@part = Part.find_by_id(params[:id])
			if @part.user_id == session[:user_id]
				@part.destroy
				redirect '/parts/index'
			end
		else
			redirect '/login'
		end
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