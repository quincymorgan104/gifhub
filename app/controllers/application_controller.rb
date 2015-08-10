require "./app/config/enviroment"
require "./app/models/gif"
require "./app/models/user"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'nuggetsrfam'
  end
  
  get '/' do
    @gifs = Gif.all.reverse
    erb :gifs
  end
  
  get '/new_gif' do
     erb :new_gif
  end
  
  get '/gifeed' do
    @gifs=Gif.all.reverse
    erb :gifeed
  end
    
  get '/signup'do
      erb :signup
  end
  
  post '/signup' do
    @user= User.new(:username => params[:username],:email => params[:email], :password => params[:password])
    @user.save
    redirect '/login'
  end
  get '/login' do
    erb :login
  end
  get '/signout' do
     session[:user_id]= nil
    redirect '/'
  end
  post '/login' do
    @user= User.find_by(:username => params[:username],:password => params[:password])
    if @user==nil
    redirect '/signup'
    else 
      session[:user_id]=@user.id
      redirect '/gifeed'
   end
  end
  post '/new_gif' do
    @user= User.find_by(:id =>  session[:user_id])
    @gif= Gif.new(:user_id => @user.id, :url => params[:url])
    @gif.save
   

    redirect '/gifeed'
  end
end