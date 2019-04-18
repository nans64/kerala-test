require 'csv'
require 'building'
require 'application_controller'
@buildings = []


CSV.foreach('public/buildings.csv', headers: true) do |row|
  @buildings << Building.new(row.to_h)
end
Building.import(@buildings)