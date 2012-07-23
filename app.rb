require 'sinatra'
require 'pp'
require 'haml' #Tilt threads
require 'json'

require './model'


configure do
  SITE = "http://localhost:9393/"
end

get '/' do
  @code = ""

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

get '/koch/:id' do
  s = JSON.parse(File.read('examples/koch.txt'))
  i = params[:id].to_i
  @code = s[i]["code"]
  @text = s[i]["text"]
  @recent = Saves.all
  haml :index
end

get '/user/:id' do
  @recent = Saves.find{|f| f.user == params[:id].to_i} || []
  haml :index
end

get '/bh/:id' do
  s = JSON.parse(File.read('examples/harvey.json'))
  @text = s[params[:id].to_i]["text"]
  #@text = ""
  @code = s[params[:id].to_i]["code"]
  haml :embed
end

get '/examples/:id' do
  s = JSON.parse(File.read('examples/koch.json'))["examples"]["Koch Snowflake"]
  @text = s[params[:id].to_i]["text"]
  @code = s[params[:id].to_i]["code"]
  haml :embed
end

get '/series' do
  s = JSON.parse(File.read('examples/harvey.json'))
  @recent = s
  @series = 'bh'
  haml :series
end

get '/examples' do
  s = JSON.parse(File.read('examples/koch.json'))["examples"]["Koch Snowflake"]
  @recent = s
  @series = 'examples'
  haml :series
end

get '/embed/:id' do
  s = Saves.find{|f| f.id == params[:id].to_i}
  if s.nil?
    @code = @text = ""
  else
    @code = s["code"]
    @text = ""
  end
  haml :embed, :format => :html5
end

get '/test' do
  haml :canvas_lines
end
get '/test2' do
  @recent = Saves
  haml :test
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

get '/help.txt' do
  File.read('public/help.txt')
end
