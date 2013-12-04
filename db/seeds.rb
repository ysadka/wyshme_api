# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This is root Doorkeeper's application which represents API itself
Doorkeeper::Application.create!(name: 'WyshMeAPIRoot',
                                redirect_uri: 'http://wyshme.com')
