class Person < ApplicationRecord

    audited # Add the log history to the model
    require 'csv'
  
    def self.importation(path)
        persons_import = []
  
      CSV.foreach(path, headers: true) do |old_app|
      
        kerala_app = Person.where(:reference => old_app[0])   
        
        if kerala_app.empty?
          persons_import << Person.new(old_app.to_h) 
        else 
          update_value(kerala_app, old_app)
          puts "Fin de l'update des valeurs [REF : #{old_app[0]}]"
        end
      end
      Person.import persons_import, batch_size: 10000
      return persons_import.count
    end 

    private_class_method def self.update_value(kerala_app,old_app)

    if kerala_app.first.revisions.count == 0 then
      kerala_data = kerala_app
    else
      kerala_data = kerala_app.first.revisions
    end

    kerala_data.each do |previous_values|
        changes = Hash.new
        changes[:firstname] = old_app[1] 
        changes[:lastname] = old_app[2]
        changes[:home_phone_number] = old_app[3] unless previous_values.home_phone_number == old_app[3]
        changes[:mobile_phone_number] = old_app[4] unless previous_values.mobile_phone_number == old_app[4]
        changes[:email] = old_app[5] unless previous_values.email.downcase == old_app[5].downcase
        changes[:address] = old_app[6] unless previous_values.address.downcase == old_app[6].downcase
        update_main_database(kerala_app,changes)
        end
    end

    private_class_method def self.update_main_database(kerala_app,changes)
        kerala_app.first.update(changes)
    end

end
