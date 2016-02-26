require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'unicode'

URL ='http://imas-db.jp/song/detail/'

get '/search' do
  title(params['keyword']).to_json
end

helpers do
  def title keyword
    html = open(URL).read
    doc = Nokogiri::HTML.parse(html)
    songs = doc.css('div.section > ul > li').map(&:text).to_a
    songs.select do |song|
      Unicode::nfkc(song).include?  Unicode::nfkc(keyword)
    end
  end
end
