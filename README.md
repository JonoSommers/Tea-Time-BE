# Tea Time

# 📽️ Overview of Project

This Rails API serves as the backend for **Tea Time**, a admin portal for Tea Time employees. It renders users data and gives employyes a change to view all customer data (name, email, subscriptions), all tea data (name, description, temp, brew time), and all subscriptions (name, price, teas involved, customers subscribed, customers previously susbcribed, description, and price). 

# Set Up

1.Fork this repo
2.Clone and rename this repo: git clone [remote-address] [new-name]
3.For example: git clone git@github.com:Tea-Time-BE.git Tea-Time-BE
4.cd into the directory
5.Install necessary dependencies with bundle install
6.Run your Rails Server with rails s
7.The Api endpoints will be accessable at http://localhost:3000/api/v1/
8.Enter control + c in your terminal to stop running the server at any time
9.All api endpoints can be tested in Postman
10.To run Rspec testing suite use bundle exec rspec ./spec/models for model tests or ./spec/requests for request tests


# 🛠️ Technologies Used, Challenges, Wins & Reflections

## Technologies Used:

	•	Backend: Rails, Postgresql
	•	Testing: RSpec, FactoryBot, and Faker, Shoulda Matchers

## Challenges Faced:

• Updating users_susbcribed and status.

• Forgetting to add in an img attribute and having to revisit the BE to update my DB, serializers, models, and tests.

## Wins & Reflections:

✅ Successfully Built database schema with many to many relationships.

✅ Implemented RESTful routing.

✅ Implemented conditioinal attribtutes.

✅ Acheived nearly 100% test coverage across the BE.

✅ Implemented error handling and sad path testing.

# 👥 Contributors

[Jono Sommers](https://github.com/JonoSommers)