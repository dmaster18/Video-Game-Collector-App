class Validator

  @@console_errors = []
  @@game_errors = []

#Class error methods (for consoles and game errors)
def self.console_errors
  @@console_errors
end

def self.game_errors
  @@game_errors
end

def self.add_console_error(error)
  self.console_errors << error unless self.console_errors.include?(error)
end

def self.add_game_error(error)
  self.game_errors << error unless self.game_errors.include?(error)
end

def self.name?(current_console)
  if current_console.name == nil || current_console.name == ""
    error = "Console must have a name."
    self.add_console_error(error)
    false
  else
    true
  end
end

def self.company?(current_console)
  if current_console.company == nil || current_console.company == ""
    error = "Console must have a company."
    self.add_console_error(error)
    false
  else
    true
  end
end

def self.valid_generation?(current_console) #Currently, 8 video game generations exist and the ninth will begin at the end of 2020
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

def self.valid_release_year?(current_console_or_game) #No console/game can be released earlier than 1972 or later than 2020
  if current_console_or_game.release_year == ""
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

def self.valid_console?(current_console) #Valid console must have a valid name, company, release year, and generation
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

def self.title?(current_game) #Valid game must have a title
  if current_game.title == nil || current_game.title == ""
    error = "Game must have a title."
    self.add_game_error(error)
    false
  else
    true
  end
end

def self.valid_rating?(current_game) #In the USA, these are the valid game ratings by the ESRB
  rating = current_game.rating
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

def self.console?(current_game) #Does game have a corresponding console/console_id
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
