# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Environment.create([{name: 'Testing'}, {name: 'Staging'}, {name: 'Production'}])
Language.create([{name: 'Ruby'}, {name: 'Java'}])
ruby = Language.where(name: 'Ruby').first
Resource.create([
                  {name: 'Load Balancer'},
                  {name: 'AWS Postgres RDS'},
                  {name: 'AWS MySQL RDS'},
                  {name: 'AWS Elasticache Memcached'},
                  {name: 'AWS Elasticache Redis'}
                ])
%w{Passenger Queue}.each do |type|
  ['1.9.3', '2.1.5', '2.2.0'].each do |version|
    Resource.create(name: "Ruby #{version} #{type}", language: ruby)
  end
end