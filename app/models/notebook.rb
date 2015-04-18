class Notebook < ActiveRecord::Base
  belongs_to :user

  has_many :icebreaker_sessions, dependent: :destroy
  has_many :questions, :through => :icebreaker_sessions
  has_many :questions, :through => :icebreaker_sessions do
    def <<(new_item)
      super( Array(new_item) - proxy_association.owner.questions)
    end
  end
end
