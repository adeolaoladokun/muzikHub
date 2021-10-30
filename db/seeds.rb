# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Setting Up Roles'
Role.destroy_all

Role.create :name => 'Admin'
Role.create :name => 'Fan'
Role.create :name => 'Creator'

puts 'Setting Up Default Users'
User.destroy_all

# Temporary admin account
admin = User.new(
    email: "admin@example.com",
    password: "please",
    password_confirmation: "please"
)
#admin.skip_confirmation!
admin.save!
#admin.roles.destroy_all
admin_role = Role.find_by_name('Admin')
admin.roles << admin_role

# Temporary creator account
creator = User.new(
    email: "creator@example.com",
    password: "please",
    password_confirmation: "please"
)
#creator.skip_confirmation!
creator.save!
#creator.roles.destroy_all
creator_role = Role.find_by_name('Creator')
creator.roles << creator_role

# Temporary fan account
fan = User.new(
    email: "adeolaoladokun@gmail.com",
    password: "please",
    password_confirmation: "please"
)
#fan.skip_confirmation!
fan.save!
#fan.roles.destroy_all
fan_role = Role.find_by_name('Fan')
fan.roles << fan_role


