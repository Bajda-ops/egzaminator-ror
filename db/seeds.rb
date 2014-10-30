# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

    
    Role.create :name => "Administrator"
    Role.create :name => "Student"
    Role.create :name => "Wykładowca"

    Group.create :name => "Kadra", :year_nr => 2000

    QuestionType.create :name => "Pojedynczego wyboru"
    QuestionType.create :name => "Wielokrotnego wyboru"

    @u = User.new(:login => "administrator", :email => "admin@admin.pl", :password => "administrator", :password_confirmation => "administrator", :name => "administrator", :surname => "administrator", :group_id => (Group.first(:conditions => {:name => "Kadra"}).id))
    @u.user_id = 666
    @u.save
    @u.update_attribute(:user_id, @u.id)
    @u.roles = ([] << Role.find_by_name("Administrator"))

    @g = Group.first(:conditions => {:name => "Kadra"})
    @g.update_attribute(:user_id, @u.id)

    GroupOwnership.create :item_id => Group.first(:conditions => {:name => "Kadra"}).id, :user_id =>  User.first(:conditions => {:login => "administrator"}).id
    UserOwnership.create :item_id =>  User.first(:conditions => {:login => "administrator"}).id, :user_id =>  User.first(:conditions => {:login => "administrator"}).id