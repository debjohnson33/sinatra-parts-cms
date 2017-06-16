class PartsController < ApplicationController
	get	'/parts/index' do
		@user = current_user
		@parts = @user.parts
		erb :'/parts/index'
	end



	get '/new' do
		erb :'/parts/new'
	end

	post '/new' do
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
		if @user.id == @part.user_id
			erb :'/parts/edit'
		else
			flash[:message] = "You do not have permission to edit this part."
			redirect '/parts/index'
		end
	end

	patch '/parts/:id' do
		if params[:name].empty? || params[:serial_number].empty? || params[:quantity].empty? || params[:manufacturer].empty?
			flash[:message] = "Please fill in all information."
			redirect '/parts/edit'
		else
			@user = current_user
			@part = Part.find_by_id(params[:id])
			@part.update(name: params[:name], serial_number: params[:serial_number], quantity: params[:quantity])
			@manufacturer = Manufacturer.find_or_create_by(name: params[:manufacturer])
			UserManufacturers.update(user_id: @user.id, manufacturer_id: @manufacturer.id)
			@part.manufacturer_id = @manufacturer.id
			@part.save

			flash[:message] = "Part updated successfully."
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

end