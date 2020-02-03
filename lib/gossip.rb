require 'bundler'
Bundler.require

require 'csv'
#Ptete besoin d'un path
require 'comments'
class Gossip
  attr_reader :author, :content
  attr_accessor :comments

  def initialize(author, content, comment = nil)
    @author = author
    @content = content
    @comments = comment
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      if @comments.nil? == false
        csv << [author, content, @comments.author, @comments.content, @comments.time]
      else
        csv << [author, content]
      end
    end
  end

#CSV.read retourn une [[],[],...]
#Avec map qui prends une [] en entree, on peut retourner une array dont chaque element a ete traite par le block
  def self.all
    all_gossips = CSV.read("./db/gossip.csv").map do |ary|
      (ary[2].nil? || ary[3].nil? || ary[4].nil?)  ? temp_comment = nil : temp_comment = Comments.new(ary[2], ary[3], ary[4])
      Gossip.new(ary[0], ary[1], temp_comment)
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = self.all
    return all_gossips[id]
  end

  def self.delete_all
    File.delete("db/gossip.csv")
  end

  def self.update(id, gossip_replacement)
    all_gossips = self.all
    all_gossips[id] = gossip_replacement
    self.delete_all
    all_gossips.each do |elem|
      elem.save
    end
  end
end