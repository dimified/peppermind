class Dito
  include Mongoid::Document

  # Associations
  belongs_to :user
  belongs_to :challenge

  def update_level
    if self.challenge
      if self.challenge.user.points >= 5
        self.challenge.user.level = :symbol
      end
    end
  end
end
