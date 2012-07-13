require 'sinatra'
require 'pp'
require 'haml' #Tilt threads

require 'model'


configure do
  SITE = "http://localhost:9393/"
end

get '/' do
  @code = ""
	@hash = ''

  @recent = Saves.all
  
  haml :index
end

post '/' do
  pp params.keys
	code = params[:code]
	img = params[:img]
	s = Saves.new(:code => code, :img => img)
	s.save
  @code = params[:code]
	@hash = s.id

  @recent = Saves.all
	haml :index
end

get '/images/:id' do 
  s = Saves.find{|f| f.id == params[:id].to_i}
	#content_type 'image/png'
  #"data:image/png;base64,#{s.img}"
	"<img src=\"data:image/png;base64,#{s.img}\">"
end

get '/:id' do
  s = Saves.find{|f| f.id == params[:id].to_i}
  if s.nil?
    @code = ""
	  @hash = ''
  else
    @code = s[:code]
	  @hash = s[:id]
  end

  @recent = Saves
  
  haml :index
end


get 'static' do
end
