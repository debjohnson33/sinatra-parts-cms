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
			 flash[:message] = "That username and/or password did not match what we have on record. Please try again."
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
			flash[:message] = "Please fill in all information."
			redirect '/new'
		else
			@user = current_user
			@part = Part.new(name: params[:name], serial_number: params[:serial_number], quantity: params[:quantity], user_id: session[:user_id])
			@manufacturer = Manufacturer.find_or_create_by(name: params[:manufacturer])
			UserManufacturers.create(user_id: @user.id, manufacturer_id: @manufacturer.id)
			@part.manufacturer_id = @manufacturer.id
			@part.save
			flash[:message] = "Successfully created part."
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
		@user = current_user
		if @user.user_id == @part.user_id
			erb :'/parts/edit'
		else
			flash[:message] = "You do not have permission to edit this part."
			redirect '/parts/index'
		end
	end

	patch '/parts/:id' do
		if params[:name].empty? || params[:serial_number].empty? || params[:quantity].empty? || params[:manufacturer].empty?
			redirect '/parts/edit'
		else
			@part = Part.find_by_id(params[:id])
			@part.update(name: params[:name], serial_number: params[:serial_number], quantity: params[:quantity], manufacturer: params[:manufacturer])
			
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