#Classe qui permet de creer un commentaire
#la variable answer c'est pour ajouter des reponses a chaque commentaires, mais pour le moment ce n'est pas fonctionnel

class Comments
  attr_reader :author, :content, :time
  attr_accessor :answer

  def initialize(author_comment, content_comment, time = Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    @author = author_comment
    @content = content_comment
    @time = time
    @answer = nil
  end

  def add_answer(answer_to_add)
    answer = answer_to_add
  end
end