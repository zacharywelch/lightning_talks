# Lightning Talk App

Sharing is caring :purple_heart:

## Screenshots

![sessions](https://user-images.githubusercontent.com/2184939/30719189-8d0e04f6-9ef0-11e7-8639-3632ad5eb5e7.png)
![member-talks](https://user-images.githubusercontent.com/2184939/30719214-a0170962-9ef0-11e7-9d1c-ebabe76c74bc.png)
![member-followers](https://user-images.githubusercontent.com/2184939/30719125-4bce8b14-9ef0-11e7-91c3-9b89bf0a2f37.png)
![talk](https://user-images.githubusercontent.com/2184939/30719238-b587f09a-9ef0-11e7-84f7-b246624b58f1.png)

## Installation

Follow these steps to get started in development.

Clone the repository

    $ git clone git@github.com:callrail/lightning_talks.git

Switch to the project's directory

    $ cd lightning_talks

Then bundle

    $ bundle

Run the migrations

    $ rake db:migrate

Populate with sample data

    $ rake db:populate

Run tests

    $ rspec spec

:wave: Don't forget to [register](https://github.com/settings/applications/new) the application for oauth on Github otherwise you won't be able to sign in. Use `http://localhost:3000` as the **Homepage URL** and `http://localhost:3000/auth/github/callback` as the **Authorization callback URL**. For more information see [here](https://developer.github.com/apps/building-integrations/setting-up-and-registering-oauth-apps/registering-oauth-apps/).
