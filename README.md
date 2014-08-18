mkfriend
========

Test your knowledge of fellow thoughtbottles with this fun game. Can you get 10
in a row correct?

This game was built in preparation for the 2014 Summer Summit. With 50% new
hires, we can get people familiar with each other more quickly with the help of
a simple face matching game.

Getting Started
---------------

This repository comes equipped with a self-setup script:

    % ./bin/setup

After setting up, you can run the application using [foreman]:

    % foreman start

[foreman]: http://ddollar.github.io/foreman/

Importing Data
--------------

The best way to populate your locate database is with real thoughtbottles. Use
the `thoughtbot:populate` Rake task to do this:

    % rake thoughtbot:populate

It reads data from `config/people.yml`. If you change the data in that file,
re-run the rake task and it will change the existing records (unless you change
the slug, like `pat-brisbin`).

If you have fun facts that you'd like to share with the other thoughtbottles,
add it under the `trivia` key, `config/people.yml`. For an example, look under
"gabe-berke-williams".

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
