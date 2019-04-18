require 'rails_helper'

RSpec.describe Building, type: :model do

  before(:each) do 
    @building = Building.importation
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "Importation works" do # A MODIFIE
      it "should not be valid without first_name" do # First importation should add values into the database
        bad_user = User.create(last_name: "Doe")
        expect(bad_user).not_to be_valid
        # test très sympa qui permet de vérifier que la fameuse formule user.errors retourne bien un hash qui contient une erreur concernant le first_name. 
        expect(bad_user.errors.include?(:first_name)).to eq(true)
      end
    end

    describe "#first_name" do # A MODIFIE
      it "should not be valid without first_name" do # Add more values into the CSV to check if it's added succesfully
        bad_user = User.create(last_name: "Doe")
        expect(bad_user).not_to be_valid
        # test très sympa qui permet de vérifier que la fameuse formule user.errors retourne bien un hash qui contient une erreur concernant le first_name. 
        expect(bad_user.errors.include?(:first_name)).to eq(true)
      end
    end

    describe "#last_name" do # A MODIFIE 
      it "should not be valid without last_name" do # Check if manager is working when modified
        bad_user = User.create(first_name: "John")
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:last_name)).to eq(true)
      end
    end

    describe "#username" do # A MODIFIE
      it "should not be lower that 3 characters" do # Check if the global import works
        invalid_user = User.create(first_name: "John", last_name: "Doe", username: "aa")
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors.include?(:username)).to eq(true)
      end
    end

    describe "#username" do # A MODIFIE
      it "should not be lower that 3 characters" do # Check if the manager name is recognized even tough we have capitalize some part of the name
        invalid_user = User.create(first_name: "John", last_name: "Doe", username: "aa")
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors.include?(:username)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "books" do
      it "should have_many books" do
        book = Book.create(user: @user)
        expect(@user.books.include?(book)).to eq(true)
      end
    end

  end



  context "public instance methods" do

    describe "#full_name" do

      it "should return a string" do
        expect(@user.full_name).to be_a(String)
      end

      it "should return the full name" do
        user_1 = User.create(first_name: "John", last_name: "Doe", username: "johndoe")
        expect(user_1.full_name).to eq("John Doe")
        user_2 = User.create(first_name: "Jean-Michel", last_name: "Durant", username: "kikou_du_75")
        expect(user_2.full_name).to eq("Jean-Michel Durant")
      end
    end

  end


end
