class GamesController < ApplicationController

  get "/games" do
    redirect_to_main_page
    @games = current_user.games
    erb :"/games/index"
  end

  get "/games/new" do
    redirect_to_main_page
    @consoles = current_user.consoles
    @game_errors = Validator.game_errors
    erb :"/games/new"
  end

  post "/games" do
    redirect_to_main_page
    game = Game.new(title: params[:title], genre: params[:genre], release_year: params[:release_year], rating: params[:rating], developer: params[:developer], publisher: params[:publisher], country: params[:country], console_id: params[:console_id], user_id: session[:user_id])
    if Validator.valid_game?(game)
       @game = game
       @game.save
       params[:id] = @game.id
       redirect "/games"
    else
       @consoles = current_user.consoles
       @game_errors = Validator.game_errors
       erb :"/games/new"
    end
  end

  get "/games/:id" do
    redirect_to_main_page
    @game = Game.find(params[:id])
    erb :"/games/show"
  end

  get "/games/:id/edit" do
    redirect_to_main_page
    @game = Game.find(params[:id])
    @consoles = current_user.consoles
    @game_errors = Validator.game_errors
    erb :"/games/edit"
  end

  patch "/games/:id" do
    redirect_to_main_page
    game = Game.find(params[:id])
    edited_game = Game.new(title: params[:title], genre: params[:genre], release_year: params[:release_year], rating: params[:rating], developer: params[:developer], publisher: params[:publisher], country: params[:country], console_id: params[:console_id])
    if Validator.valid_game?(edited_game)
      game.update(title: params[:title], genre: params[:genre], release_year: params[:release_year], rating: params[:rating], developer: params[:developer], publisher: params[:publisher], country: params[:country], console_id: params[:console_id])
      redirect "/games/#{game.id}"
    else
      @game = Game.find(params[:id])
      @consoles = current_user.consoles
      @game_errors = Validator.game_errors
      erb :"/games/edit"
    end
  end

  delete '/games/:id' do
    @game = Game.find(params[:id])
    @game.delete
    redirect "/games"
  end

end
