mkfriend
========

Test your knowledge of fellow students with this fun game. Can you get 10
in a row correct?

Getting Started
---------------

This repository comes equipped with a self-setup script:

    % ./bin/setup

After setting up, you can run the application using [foreman]:

    % foreman start

[foreman]: http://ddollar.github.io/foreman/

Importing Data
--------------

The best way to populate your locate database is with real Turing students. Use
the `turing:populate` Rake task to do this:

    % rake turing:populate

It reads data from `config/people.yml`. If you change the data in that file,
re-run the rake task and it will change the existing records (unless you change
the slug, like `pat-brisbin`). So if you change something in
`config/people.yml`, just push it to Heroku and run:

    heroku run rake turing:populate

Voila, your changes are live.

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
