users = [
	{username: 'Test', email: 'test@email.com', password: 'Test'},
	{username: 'Test2, email: 'test2@email.com, password: 'Test2'}	
]

manufacturers = [
	{name: 'Acme'},
	{name: 'NHC'}
]

parts = [
	{name: 'Carburetor kit', serial_number: 'GKT123', quantity: 5, user_id: 1, manufacturer_id: 2},
	{name: 'Deck belt', serial_number: 'DB123', quantity: 2, user_id: 2, manufacturer_id: 1}
]

users.each do |u|
	User.create(u)
end

manufacturers.each do |m|
	Manufacturer.create(u)
end

parts.each do |p|
	Part.create(p)
end