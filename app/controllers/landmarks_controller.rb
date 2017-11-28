class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    landmark = Landmark.create(params[:landmark])
    landmark.titles.build(params[:title]) unless params[:title][:name].empty?
    landmark.figures.build(params[:figure]) unless params[:figure][:name].empty?
    landmark.save
    redirect("/landmarks/#{landmark.id}")
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id:params[:id])
    erb :"/landmarks/show"
  end

end
