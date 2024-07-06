# cloudwalk-challenge

## Instructions and details
<h1 align="center">Log Parsing Challenge</h1>

<h2 align="center">Important Notes:</h2>
<p align="center">I specifically wrote the code in a way that does not consider in any way when a player kills itself. So if a player kills itself, it doesn’t increase their kills, the match total kills and neither the kills by means.</p>
<p align="center">If a player is killed by the world more times than they killed other players, this player kills score is going to be 0 for that match.</p>
<p>I used ruby 3.0.0 while developing this, if you need it in another ruby version, just let me know and I can change it.</p>
<p>The challenge description didn't ask for any automated tests, but I did create a couple ones for the main logic in this project.</p>

<h2> How to run: </h2>

1 - First, clone the repository

```git clone git@github.com:AndreySpies/cloudwalk-challenge.git```

2 - Go to repository root path and run this command to install it's dependencies

```bundle install```

3 - Now, you're ready to run the project, for that, from the root path you need to run the main file passing the name/filepath of the log file you want to try, e.g. if the log file is in the root path (and I did leave one there), run:

```ruby lib/main.rb qgames.log```

4 - To run the automated tests, simply:

```bundle exec rspec```
