require "./app/config/enviroment"
require "./app/models/gif"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
  end
  
  get '/' do
    @gifs = Gif.all
    erb :gifs
  end
  
  get '/new_gif' do
     erb :new_gif
  end
  get '/gifeed' do
    @gifs=Gif.all
    erb :gif_feed
  end
    
  get '/signup'do
      erb :signup
  end
  post '/signup' do
    @user= User.new(:username => params[:username],:email => params[:email], :password => params[:password])
    @user.save
    redirect '/new_gif'
  end
  
  post '/new_gif' do
    @user= User.find_by(:username => params[:username])
    @gif= Gif.new(:user_id => @user.id, :url => params[:url])
    @gif.save
   

    redirect '/gifeed'
  end
end