class Validator #Validator class contains methods that validate consoles and games before they are saved into the database

  @@console_errors = []
  @@game_errors = []

#Class error methods (for consoles and game errors)

def self.console_errors #Holds list of console errors to tell user why console could not be saved to the database
  @@console_errors
end

def self.game_errors #Holds list of game errors to tell user why console could not be saved to the database
  @@game_errors
end

def self.add_console_error(error) #Ensures that no duplicate console errors are added to @@console_errors
  self.console_errors << error unless self.console_errors.include?(error)
end

def self.add_game_error(error)  #Ensures that no duplicate console errors are added to @@game_errors
  self.game_errors << error unless self.game_errors.include?(error)
end

def self.name?(current_console) #Produces an error if user doesn't enter a name for the new or edited console
  if current_console.name == nil || current_console.name == ""
    error = "Console must have a name."
    self.add_console_error(error)
    false
  else
    true
  end
end

def self.company?(current_console) #Produces an error if user doesn't enter a company for the new or edited console
  if current_console.company == nil || current_console.company == ""
    error = "Console must have a company."
    self.add_console_error(error)
    false
  else
    true
  end
end

def self.valid_generation?(current_console) #Produces an error if user enters a value that is not an integer between 1 and 9 for the optional console generation field. No console generations exists beyond 9, at the moment.
  if current_console.generation == ""
    true
  else
    generation = current_console.generation.to_i
    if generation.class != Integer || generation == 0
      error = "Generation must be an integer"
      self.add_console_error(error)
    elsif generation < 1
      error = "No console generation exists before Generation 1."
      self.console_errors
      false
    elsif generation > 9
      error = "No console generation exists beyond the ninth generation yet."
      self.add_console_error(error)
      false
    else
      true
    end
  end
end

def self.valid_release_year?(current_console_or_game) #Produces an error if the user enters an optional release year that is not between 1972 (the year Atari brought Pong to the arcades) and 2020, the current year.
    true
  else
    release_year = current_console_or_game.release_year.to_i
    if release_year.class != Integer || release_year == 0
      error = "Release year must be an integer between 1972 and 2020."
      self.add_console_error(error) if current_console_or_game.class == Console
      self.add_game_error(error) if current_console_or_game.class == Game
      false
    elsif release_year > 2020
      error = "Release year cannot be beyond current year, 2020."
      self.add_console_error(error) if current_console_or_game.class == Console
      self.add_game_error(error) if current_console_or_game.class == Game
      false
    elsif release_year < 1972
      error = "Release year cannot be before 1972."
      self.add_console_error(error) if current_console_or_game.class == Console
      self.add_game_error(error) if current_console_or_game.class == Game
      false
    else
      true
    end
  end
end

def self.valid_console?(current_console) #A valid console must have a valid name, company, release year, and generation
  self.name?(current_console)
  self.company?(current_console)
  self.valid_release_year?(current_console)
  self.valid_generation?(current_console)
  if self.name?(current_console) && self.company?(current_console) && self.valid_release_year?(current_console) && self.valid_generation?(current_console)
    true
  else
    false
  end
end

def self.title?(current_game) #Produces an error if user doesn't enter a title for the new or edited game
  if current_game.title == nil || current_game.title == ""
    error = "Game must have a title."
    self.add_game_error(error)
    false
  else
    true
  end
end

def self.valid_rating?(current_game) #Prdouces an error if the user enters a game rating (an optional field) other than one dictated by the ESRB, the USA game ratings board.
  if rating == ""
    true
  else
    if rating == "E" || rating == "T" || rating == "M" || rating == "AO"  || rating == "RP"
      true
    else
      error = "Invalid rating. Your game must be rated either 'E', 'T', 'M', 'AO', or 'RP'."
      self.add_game_error(error)
      false
    end
  end
end

def self.console?(current_game) #Produces an error if user doesn't give console
  if current_game.console_id != nil
    true
  else
    error = "Game must belong to a console."
    self.add_game_error(error)
    false
  end
end

def self.valid_game?(current_game)
  self.title?(current_game)
  self.valid_release_year?(current_game)
  self.valid_rating?(current_game)
  self.console?(current_game)
  if self.title?(current_game) && self.valid_release_year?(current_game) && self.valid_rating?(current_game) && self.console?(current_game)
    true
  else
    false
  end
end

end
