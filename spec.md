# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Used sinatra.
- [x] Use ActiveRecord for storing information in a database - used ActiveRecord.
- [x] Include more than one model class - Models: User, Part, Manufacturer, and UserManufacturers.
- [x] Include at least one has_many relationship - User has many Parts, Manufacturer has many Parts, User has many UserManufacturers, User has many Manufacturers through UserManufacturers, Manufacturer has many Users through UserManufacturers, and Manufacturer has many UserManufacturers.
- [x] Include user accounts - Capability for new user to sign up and current user to login.
- [x] Ensure that users can't modify content created by other users - Users can look at any part, but if they try to edit one that is not their own, they will get a message that says they don't have the permission to edit the part.
- [x] Include user input validations - Validates presence of input for each part of form.
- [x] Display validation failures to user with error message - User receives message if any text box is left blank.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code - README complete.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
