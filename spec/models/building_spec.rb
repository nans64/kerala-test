require 'rails_helper'

RSpec.describe Building, type: :model do

  let(:file_path) { "tmp/test.csv" }
  let!(:csv) do
    CSV.open(file_path, "w") do |csv|
      rows.each do |row|
        csv << row.split(",")
      end
    end
  end

  context "validation" do

    it "should not produce an error when importing empty arrays" do
      assert_nothing_raised do
        Building.import []
        Building.import %w(reference manager_name), []
      end
    end

    end

    describe "Importation works" do # A MODIFIE
      it "should not be valid without first_name" do # First importation should add values into the database

      end
    end

    describe "#first_name" do # A MODIFIE
      it "should not be valid without first_name" do # Add more values into the CSV to check if it's added succesfully

      end
    end

    describe "#last_name" do # A MODIFIE 
      it "should not be valid without last_name" do # Check if manager is working when modified

      end
    end

    describe "#username" do # A MODIFIE
      it "should not be lower that 3 characters" do # Check if the global import works

      end
    end

    describe "#username" do # A MODIFIE
      it "should not be lower that 3 characters" do # Check if the manager name is recognized even tough we have capitalize some part of the name

      end
    end


end
