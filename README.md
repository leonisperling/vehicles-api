# Code Challenge door2door


## Installation Instructions

In order to run this project it's necessary to install some dependencies, but first make sure you have the repository cloned:

```bash
git clone git@github.com:leonisperling/vehicles-api.git
```


**Ruby 2.6.5**

```bash
rbenv install 2.6.5
```

**PostgreSQL, using Homebrew**

```bash
brew install postgresql
```

**Rails 5.2.4**

```bash
gem install rails
```

**Project Gems**

```bash
# In the project's folder
bundle install
```

Following these steps will ensure you have everything necessary to run this project.


## Running this Project


Migrate and create the database:

```bash
rails db:create db:migrate
```

Start the rails server by running:

```bash
# In the project's folder
rails server
```

##  RSpec
I implemented some basic tests after doing some research. I added tests to check if the vehicle:
* Is being properly created 
* Is successfully de-registered
* If its location is with radius of the office coordinates


## Technologies used
### Rails
It offers an API only starting project and defaults that allow us to expand the project if needed.

### Geocoder
Geocoder offers basic geospatial queries, such as `search within radius` and this helped me solve one part of the challenge.  

### ActionCable
I used ActionCable because it seamlessly integrates WebSockets with the rest of your Rails application. This allowed me to broadcast the locations of the vehicles.

## Addressing the Challenge
* I added the status `active` for the vehicles, as I thought that vehicles should not be active or inactive, because we do not want to lose the data they transmitted during the shifts. 

* In the `create` method of the locations, I allow location updates to be posted only when the vehicle is active. I do this by using an early return, which checks if the vehicle is active or not. 

* In order to check that a vehicle is within the office radius, I made use of the `distance_between` method of Geocoder. This method calculates the distance between to spaces and I am not allowing any data postings if the vehicles exceed the radius. 

* In order to make the code more dynamic, for more office locations, I would make use of hashes, in which I would insert all the locations and then iterate over the hash.

## Delivery
The project is hosted on Heroku and can be found on https://vehicles-api-d2d.herokuapp.com/ and you can test in the simulator by running `yarn start vehicles-api-d2d.herokuapp.com`.







