WyshMe API
==========

This is API application to access to users' boards, items, categories, and users.

To install the application locally clone current repository, go to repo's root and run in terminal:

    $ bundle install
    $ RAILS_ENV=development rake db:create
    $ RAILS_ENV=development rake db:schema:load

Test application with:

    $ rake test

TODO:

1. Generate and return API's oAuth token on successfull user login.

2. Add roles, provide access to API's endpoints depend on role.
