class ConsolesController < ApplicationController

  get "/consoles" do
    redirect_to_main_page
    @consoles = current_user.consoles
    erb :"/consoles/index"
  end

  get "/consoles/new" do
    redirect_to_main_page
    @console_errors = Validator.console_errors
    erb :"/consoles/new"
  end

  post "/consoles" do
    redirect_to_main_page
    console = Console.new(name: params[:name], company: params[:company], release_year: params[:release_year], generation: params[:generation], country: params[:country], launch_price: params[:launch_price], units_sold: params[:units_sold], user_id: session[:user_id])
    if Validator.valid_console?(console)
       @console = console
       @console.save
       params[:id] = @console.id
       redirect "/consoles"
    else
       @console_errors = Validator.console_errors
       erb :"/consoles/new"
    end
  end

  get "/consoles/:id" do
    redirect_to_main_page
    @console = Console.find(params[:id])
    erb :"/consoles/show"
  end

  get "/consoles/:id/edit" do
    redirect_to_main_page
    @console = Console.find(params[:id])
    @console_errors = Validator.console_errors
    erb :"/consoles/edit"
  end

  patch "/consoles/:id" do
    redirect_to_main_page
    console = Console.find(params[:id])
    edited_console = Console.new(name: params[:name], company: params[:company], release_year: params[:release_year], generation: params[:generation], country: params[:country], launch_price: params[:launch_price], units_sold: params[:units_sold])
    if Validator.valid_console?(edited_console)
      console.update(name: params[:name], company: params[:company], release_year: params[:release_year], generation: params[:generation], country: params[:country], launch_price: params[:launch_price], units_sold: params[:units_sold])
      redirect "/consoles/#{console.id}"
    else
      @console = Console.find(params[:id])
      @console_errors = Validator.console_errors
      erb :"/consoles/edit"
    end
  end

  delete '/consoles/:id' do
    @console = Console.find(params[:id])
    @console.delete
    redirect "/consoles"
  end

end
