class Gossip
  attr_reader :author, :content, :comment

  def initialize(content, author, comment)
    @content = content
    @author = author
    @comment = comment
  end

  def save
    CSV.open("db/gossip.csv", "ab") do |csv|
      csv << [@content, @author, @comment]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1], csv_line[2])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = Gossip.all
    return all_gossips[id.to_i-1]
  end

  def self.update(id, author, content, comment)
    all_gossips = Gossip.all
    all_gossips.delete_at(id)
    all_gossips.insert(id, Gossip.new(author, content, comment))
    CSV.open("db/gossip.csv", "w") do |csv|
      all_gossips.each do |gossip|
        csv << [gossip.author, gossip.content, gossip.comment]
      end
    end
  end

end