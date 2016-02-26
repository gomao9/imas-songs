require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

URL ='http://imas-db.jp/song/detail/'

get '/search' do
  title(params['keyword']).to_json
end

helpers do
  def title keyword
    html = open(URL).read
    doc = Nokogiri::HTML.parse(html)
    songs = doc.css('div.section > ul > li').map(&:text).to_a
    songs.select{|song| song.include? keyword}
  end
end
