class FiguresController < ApplicationController

  get '/figures' do
   @figures = Figure.all
   erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    # @figure = Figure.create(:name => params["figure"]["name"])
    # @landmark = Landmark.find_or_create_by(name: params["landmark"])
    # @figure.landmark = @landmark
    #
    # @title = Title.find_or_create_by(name: params["title"])
    # @figure.title = @title
    # redirect to "/figures/#{@figure.name}"
    figure = Figure.create(params[:figure])
    figure.titles.build(params[:title]) unless params[:title][:name].empty?
    figure.landmarks.build(params[:landmark]) unless params[:landmark][:name].empty?
    figure.save
    redirect("/figures/#{figure.id}")
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id:params[:id])
    erb :"/figures/show"
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    @figure.landmarks.find_or_create_by(params[:landmark]) unless params[:landmark][:name].empty?
    @figure.titles.find_or_create_by(params[:title]) unless params[:title][:name].empty?
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :"/figures/edit"
  end

end
