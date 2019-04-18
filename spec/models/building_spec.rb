require 'rails_helper'

    RSpec.describe Building, type: :model do
      before do
        CSV.open('public/buildings.csv', 'w') do |csv|
          csv << %w[reference address zip_code city country manager_name]
          csv << ['1', '10 Rue La bruyère', '75009', 'Paris', 'France',	'Martin Faure']
          csv << ['2', '40 Rue René Clair', '75018', 'Paris', 'France',	'Martin Faure']
          csv << ['3', '10 Rue La bruyère', '75009', 'Paris', 'France', 'Martin Faure']
        end

        CSV.open('public/buildings_add_value.csv', 'w') do |csv|
          csv << %w[reference address zip_code city country manager_name]
          csv << ['4', '27 Rue Clauzel', '75009', 'Paris', 'France',	'Nans Noel']
        end

        CSV.open('public/buildings_update_value.csv', 'w') do |csv|
          csv << %w[reference address zip_code city country manager_name]
          csv << ['1', '29 Rue La Mouche', '64400', 'Oloron ste marie', 'France',	'Gabe Newell']
          csv << ['2', '40 Rue René Clair', '75018', 'Paris', 'France', 'Martin Scorsese']
          csv << ['3', '245 Carrer de la Marina', '80155', 'Barcelona', 'Espagne', 'Martin Martin']
        end
    
        CSV.open('public/buildings_wrong.csv', 'w') do |csv|
          csv << %w[reference address zip_code city country manager_name]
          csv << ['1', '10 Rue La bruyère', '75009', 'Paris', 'France',	'Martin Faure']
          csv << ['2', '40 Rue René Clair', '75018', 'Paris', 'France',	'Martin Faure']
          csv << ['3', '40 Rue des Vinaigriers', '75011', 'Paris', 'France']
          csv << ['3', '40 Rue des Vinaigriers', '75011', 'Paris', 'France']
        end
        Building.importation('tmp/buildings.csv')
      end

      describe 'Parse the database to check if CSV datas are into the Building table' do
        context "when the CSV has been imported successfully" do
          it 'successfully imports the row' do
            expect(Building.count).to(eq(3))
          end
    
          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 1).manager_name).to(eq('Martin Faure'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 2).address).to(eq('40 Rue René Clair'))
          end
        end
      end

      describe 'Add one row' do
        before do
          Building.importation('tmp/buildings_add_value.csv')
        end
        context "when there's a change into the csv" do
          it 'successfully imports the row' do
            expect(Building.find_by(reference: 4).reference).to(eq("4"))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 4).address).to(eq('27 Rue Clauzel'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 4).manager_name).to(eq('Nans Noel'))
          end

        end
      end

      describe 'Update the values' do
        before do
          Building.importation('tmp/buildings_update_value.csv')
        end
        context "when there's a change into the csv" do
          it 'successfully update the row' do
            expect(Building.count).to(eq(3))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 3).address).to(eq('245 Carrer de la Marina'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 3).zip_code).to(eq('80155'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 3).city).to(eq('Barcelona'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 3).country).to(eq('Espagne'))
          end

          it 'gives the value nil to the missing attribute' do
            expect(Building.find_by(reference: 3).manager_name).to(eq('Martin Faure'))
          end
        end
        end
      
end
