require 'rails_helper'

RSpec.describe Person, type: :model do
      before do
        Person.importation('public/people.csv')
      end

      describe 'Parse the database to check if CSV datas are into the Person table' do
        context "when the CSV has been imported successfully" do
          it 'successfully imports the row' do
            expect(Person.count).to(eq(3))
          end
    
          it 'retrieves the value Manager Name for the reference 1' do
            expect(Person.find_by(reference: 1).firstname).to(eq('Henri'))
          end

          it 'retrieves the value Address for the reference 2' do
            expect(Person.find_by(reference: 2).address).to(eq('40 Rue René Clair'))
          end
        end
      end

      describe 'Add one row using a new CSV file' do
        before do
          Person.importation('public/people_add_value.csv')
        end
        context "when there's a change into the csv" do
          it 'successfully imports the row' do
            expect(Person.find_by(reference: 4).reference).to(eq("4"))
          end

          it 'retrieves the value Address for the reference 4' do
            expect(Person.find_by(reference: 4).address).to(eq('3 Place des oustalots'))
          end

          it 'retrieves the value Manager Name for the reference 4' do
            expect(Person.find_by(reference: 4).firstname).to(eq('Axel'))
          end

          it 'retrieves the value Manager Name for the reference 4' do
            expect(Person.find_by(reference: 4).home_phone_number).to(eq('0123456790'))
          end

          it 'retrieves the value Manager Name for the reference 4' do
            expect(Person.find_by(reference: 4).mobile_phone_number).to(eq('0623456790'))
          end

          it 'retrieves the value Manager Name for the reference 4' do
            expect(Person.find_by(reference: 4).email).to(eq('axel.noel@gmail.com'))
          end

        end
      end

      describe 'Update the values' do
        before do
          Person.importation('public/people_update_value.csv')
        end
        context "when there's an update into the CSV" do
          it 'successfully update the row' do
            expect(Person.count).to(eq(3))
          end

          it 'retrieves the value Home number for the reference 3' do
            expect(Person.find_by(reference: 3).home_phone_number).to(eq('0600000'))
          end

          it 'retrieves the value Firstname for the reference 3' do
            expect(Person.find_by(reference: 1).firstname).to(eq('Michel'))
          end

          it 'retrieves the value Lastname for the reference 3' do
            expect(Person.find_by(reference: 1).lastname).to(eq('Miterrand'))
          end

          it 'retrieves the value Home number for the reference 3' do
            expect(Person.find_by(reference: 1).home_phone_number).to(eq('0123456781'))
          end

          it 'retrieves the value Mobile number for the reference 3' do
            expect(Person.find_by(reference: 1).mobile_phone_number).to(eq('0623456781'))
          end
          it 'retrieves the value Email for the reference 3' do
            expect(Person.find_by(reference: 1).email).to(eq('michel.miterrand@gmail.com'))
          end
          it 'retrieves the value Address for the reference 3' do
            expect(Person.find_by(reference: 1).address).to(eq('10 Rue clauzel'))
          end
        end
        end

        describe 'Parse the database to check if CSV datas are into the Person table' do
          before do
            Person.importation('public/people_many_data.csv')
          end
          context "when the CSV has been imported successfully" do
            it 'successfully imports the rows' do
              expect(Person.count).to(eq(1000))
            end
          end
        end
      
end
