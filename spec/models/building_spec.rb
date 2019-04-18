require 'rails_helper'

RSpec.describe Building, type: :model do
      before do
        Building.importation('public/buildings.csv')
      end

      describe 'Parse the database to check if CSV datas are into the Building table' do
        context "when the CSV has been imported successfully" do
          it 'successfully imports the row' do
            expect(Building.count).to(eq(3))
          end
    
          it 'retrieves the value Manager Name for the reference 1' do
            expect(Building.find_by(reference: 1).manager_name).to(eq('Martin Faure'))
          end

          it 'retrieves the value Address for the reference 2' do
            expect(Building.find_by(reference: 2).address).to(eq('40 Rue René Clair'))
          end
        end
      end

      describe 'Add one row using a new CSV file' do
        before do
          Building.importation('public/buildings_add_value.csv')
        end
        context "when there's a change into the csv" do
          it 'successfully imports the row' do
            expect(Building.find_by(reference: 4).reference).to(eq("4"))
          end

          it 'retrieves the value Address for the reference 4' do
            expect(Building.find_by(reference: 4).address).to(eq('27 Rue Clauzel'))
          end

          it 'retrieves the value Manager Name for the reference 4' do
            expect(Building.find_by(reference: 4).manager_name).to(eq('Nans Noel'))
          end

        end
      end

      describe 'Update the values' do
        before do
          Building.importation('public/buildings_update_value.csv')
        end
        context "when there's an update into the CSV" do
          it 'successfully update the row' do
            expect(Building.count).to(eq(3))
          end

          it 'retrieves the value Address for the reference 3' do
            expect(Building.find_by(reference: 3).address).to(eq('245 Carrer de la Marina'))
          end

          it 'retrieves the value Zip Code for the reference 3' do
            expect(Building.find_by(reference: 3).zip_code).to(eq('80155'))
          end

          it 'retrieves the value City for the reference 3' do
            expect(Building.find_by(reference: 3).city).to(eq('Barcelona'))
          end

          it 'retrieves the value Country for the reference 3' do
            expect(Building.find_by(reference: 3).country).to(eq('Espagne'))
          end

          it 'retrieves the value Manager Name for the reference 3' do
            expect(Building.find_by(reference: 3).manager_name).to(eq('Martin Martin'))
          end
        end
        end
        
        describe 'Parse the database to check if CSV datas are into the Building table' do
          before do
            Building.importation('public/buildings_many_data.csv')
          end
          context "when the CSV has been imported successfully" do
            it 'successfully imports the rows' do
              expect(Building.count).to(eq(100))
            end
          end
        end
      
end
