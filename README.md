# Lightning Talk App

Sharing is caring :purple_heart:

## Installation

Follow these steps to get started in development.

Clone the repository

    $ git clone git@github.com:zacharywelch/lightning_talks.git

Switch to the project's directory

    $ cd lightning_talks

Then bundle

    $ bundle

Copy database.yml.sample as database.yml

    $ cp config/database.yml.sample config/database.yml

Copy secrets.yml.sample as secrets.yml

    $ cp config/secrets.yml.sample config/secrets.yml

Copy aws.yml.sample as aws.yml

    $ cp config/aws.yml.sample config/aws.yml

Make sure all config files mentioned above are filled with the proper configuration data

Run the migrations

    $ rake db:migrate

Populate with sample data

    $ rake db:populate

Run tests

    $ rspec spec
