# Video Game Collector

Video Game Collector is a Sinatra web application that allows users to store their video game and console collections into a database, in which they can add, view, edit, and remove individual games and consoles as they see fit. This app is very useful for any gamer who has a lot of consoles and games and wants to keep track of them to know what they have to ensure they don't buy the same game or console again by accident.

## Installation

Video Game Collector can be downloaded from https://github.com/dmaster18/video_game_collector. Once downloaded, go to the program's directory from your local Terminal/Command Line and then run bundle install or bundle exec install to ensure all the dependencies are installed. Once all the dependencies have been installed, run the shotgun command from your Mac or Linux machine Terminal or rackup command from your Windows PC initiate the web application.

## Usage

Once your local server is up and running the application, go to the following HTMl address to arrive at the welcome page: "http://127.0.0.1:9393(OR YOUR LOCAL SERVER)/users". From the welcome page, the user will be greeted with buttons to either sign up, if the user is new, or log in, if the user already has an account. When signing up for the first time, the user must make sure to enter a unique username as well as a password that is at least eight characters long and contains at least one capital letter, one number, and one special character. If the user fails to sign up or log in, he or she should be greeted with error(s) in red text alerting him or her of the mistake.

Once logged in, the user will be sent to a home page that gives options to either view his or her entire game or console collections, or to add to those collections. As the user tries to add new consoles/games or edit exists ones, he or she will realize that certain fields are mandatory. In order to create a valid console, a user must enter data into both the console's name and company fields. Likewise, to create a valid game, the user must give the game a title and assign the game to a corresponding console, at the very least. Furthermore, if the user decides to enter data into optional fields, he or she will discover that some of these fields have restrictions.  For instance, if a user decides to enter a console generation, it must be an integer between 1 through 9, since there are currently only 9 console generations. Similarly, a user must enter a valid ESRB age rating, such as "E", "T", or "M". Lastly, for both consoles and games, if a user decides to enter a release year, that release year must be in between 1972 (the year Atari introduced Pong to the arcades) and the current year, 2020.

If the user ever wants to access his main account page, each page of the Video Game Collector web app conveniently has a home page button, which has a logout button once the user has finished viewing and modifying the collections for the day.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dmaster18/video_game_collector/pulls. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Video Game Collector project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dmaster18/top_one_hundred_movies/blob/master/CODE_OF_CONDUCT.md).
