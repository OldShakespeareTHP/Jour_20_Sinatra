require 'bundler'
Bundler.require

# $:.unshift File.expand_path("./../lib/", __FILE__)
# require_relative 'lib/gossip.rb'
require 'gossip.rb'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    id_ = params['id']
    pp Gossip.find(id_.to_i)
    erb :show, locals: {id_of_page: id_, gossip: Gossip.find(id_.to_i)}
    # gossip = Gossip.find(id_.to_i)
    # "Gossip a l'id #{id_} : #{gossip.author}, #{gossip.content}"
  end

  post '/gossips/:id/' do
    id_ = params['id'].to_i
    comment = Comments.new(params['com_author'], params['com_content'])
    gossip_to_comment = Gossip.find(id_)
    gossip_with_com = Gossip.new(gossip_to_comment.author, gossip_to_comment.content, comment)
    pp gossip_with_com
    Gossip.update(id_, gossip_with_com)
    redirect "/gossips/#{params['id']}/"
  end

  get '/gossips/:id/edit/' do
    erb :edit
  end

  post '/gossips/:id/edit/' do
    gossip_replacement = Gossip.new(params["gossip_author"], params["gossip_content"])
    id_ = params['id'].to_i
    Gossip.update(id_, gossip_replacement)
    redirect '/'
  end
end
