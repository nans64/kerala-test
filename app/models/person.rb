class Person < ApplicationRecord

    audited # Add the log history to the model
    require 'csv'
  
    def self.importation
        persons_import = []
  
      CSV.foreach('public/people.csv', headers: true) do |old_app|
      
        kerala_app = Person.where(:reference => old_app[0])   
        
        if kerala_app.empty?
          persons_import << Person.new(old_app.to_h) 
        else 
          update_value(kerala_app, old_app)
          puts "Fin de l'update des valeurs [REF : #{old_app[0]}]"
        end
      end
      Person.import persons_import
      puts "Nous avons ajouté #{persons_import.count} lignes depuis notre fichier CSV"
    end 

    private_class_method def self.update_value(kerala_app,old_app)

    kerala_app.first.revisions.each do |previous_values|
        
        update_home_phone_number(kerala_app,old_app) unless previous_values.home_phone_number == old_app[3]
        update_mobile_phone_number(kerala_app,old_app) unless previous_values.mobile_phone_number == old_app[4]
        update_email(kerala_app,old_app) unless previous_values.email.downcase == old_app[5].downcase
        update_person_address(kerala_app,old_app) unless previous_values.address.downcase == old_app[6].downcase
        
        end
    update_main_database(kerala_app,old_app)
    end

    private_class_method def self.update_home_phone_number(kerala_app,old_app)
        kerala_app.first.update(:home_phone_number => old_app[3])
        puts "Mise à jour du HOME_PHONE_NUMBER pour la référence : #{old_app[0]}"
    end

    private_class_method def self.update_mobile_phone_number(kerala_app,old_app)
        kerala_app.first.update(:mobile_phone_number => old_app[4])
        puts "Mise à jour du MOBILE_PHONE_NUMBER pour la référence : #{old_app[0]}"
    end

    private_class_method def self.update_email(kerala_app,old_app)
        kerala_app.first.update(:email => old_app[5])
        puts "Mise à jour de l'EMAIL pour la référence : #{old_app[0]}"
    end

    private_class_method def self.update_person_address(kerala_app,old_app)
        kerala_app.first.update(:address => old_app[6])
        puts "Mise à jour de l'ADDRESS pour la référence : #{old_app[0]}"
    end

    private_class_method def self.update_main_database(kerala_app,old_app)
        kerala_app.first.update(:firstname => old_app[1], :lastname => old_app[2])
        puts "Mise à jour des informations restantes pour la référence : #{old_app[0]}"

    end

end
