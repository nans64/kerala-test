class Building < ApplicationRecord

  audited # Add the log history to the model
  require 'csv'

  def self.importation(path)
    buildings_import = []

    CSV.foreach(path, headers: true) do |old_app|
    
      kerala_app = Building.where(:reference => old_app[0])   
      
      if kerala_app.empty?
        buildings_import << Building.new(old_app.to_h) 
      else 
        update_value(kerala_app, old_app)
        puts "Fin de l'update des valeurs [REF : #{old_app[0]}]"
      end
    end
    Building.import buildings_import, batch_size: 10000
    return buildings_import.count
  end 

  private_class_method def self.update_value(kerala_app,old_app)

    if kerala_app.first.revisions.count == 0 then
      kerala_data = kerala_app
    else
      kerala_data = kerala_app.first.revisions
    end

    changes = Hash.new

    kerala_data.each do |previous_values|
      changes[:address] = old_app[1] 
      changes[:zip_code] = old_app[2]
      changes[:city] = old_app[3]
      changes[:country] = old_app[4]
      changes[:manager_name] = old_app[5] unless previous_values.manager_name == old_app[5]
      
    end
    update_main_database(kerala_app,changes)
  end

  private_class_method def self.update_main_database(kerala_app,changes)
    kerala_app.first.update(changes)
  end
end