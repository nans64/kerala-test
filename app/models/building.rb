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

    kerala_app.first.revisions.each do |previous_value|
      update_manager(kerala_app,old_app)  unless previous_value.manager_name == old_app[5]
    end
    update_main_database(kerala_app,old_app)
  end

  private_class_method def self.update_manager(kerala_app,old_app)
    kerala_app.first.update(:manager_name => old_app[5])
    return "Mise à jour du MANAGER_NAME pour la référence : #{old_app[0]}"
  end

  private_class_method def self.update_main_database(kerala_app,old_app)
    kerala_app.first.update(:address => old_app[1], :zip_code => old_app[2], :city => old_app[3], :country => old_app[4])
    return "Mise à jour des autres informations pour la référence : #{old_app[0]}"
  end
end