class Building < ApplicationRecord

  audited # Add the log history to the model
  require 'csv'

  def self.importation
    buildings_import = []

    CSV.foreach('public/people.csv', headers: true) do |old_app|
    
      kerala_app = Building.where(:reference => old_app[0])   
      
      if kerala_app.empty?
        buildings_import << Building.new(old_app.to_h) 
      else 
        update_value(kerala_app, old_app)
        puts "Fin de l'update des valeurs [REF : #{old_app[0]}]"
        raise old_app[0] # Raise the reference old_app == raise result
      end
    end
    Building.import buildings_import, batch_size: 1000
    puts "Nous avons ajouté #{buildings_import.count} lignes depuis notre fichier CSV"
    raise buildings_import.count
  end 

  private_class_method def self.update_value(kerala_app,old_app)

    kerala_app.first.revisions.each do |previous_value|
      update_manager(kerala_app,old_app)  unless previous_value.manager_name.downcase == old_app[5].downcase
    end
    update_main_database(kerala_app,old_app)
  end

  private_class_method def self.update_manager(kerala_app,old_app)
    kerala_app.first.update(:manager_name => old_app[5])
    puts "Mise à jour du MANAGER_NAME pour la référence : #{old_app[0]}"
  end

  private_class_method def self.update_main_database(kerala_app,old_app)
    kerala_app.first.update(:address => old_app[1], :zip_code => old_app[2], :city => old_app[3], :country => old_app[4])
    puts "Mise à jour des autres informations pour la référence : #{old_app[0]}"
  end
end