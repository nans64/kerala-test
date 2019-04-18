# How to execute the script

1 - Clone the repo 

2 - bundle install

3 - rails db:create

4 - rails db:migrate

5 - bundle exec rspec

6 - rails c

7 - Building.importation('public/buildings.csv')

8 - Person.importation('public/people.csv')

# GEM USED
- Activerecord-import < Boost the import
- Audited < Generate data log on the fly

# Explanation

I used the gem activerecord-import to boost the initial import. 

It would have been faster to manage the data if reference was the incremental number for both app but it would have create
conflicts when a new data is inserted from the OldApp and the KeralaApp at the same time.


I chose to divide the script into two part :

1 - Import the new value by checking if the reference exist already or not

2 - Checking the duplicate data to make sure to import a new version of the data when it's required.

# Version

- Rails 5.2.3
- Ruby 2.5.1
- SQLite
