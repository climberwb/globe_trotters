class IcebreakerSession < ActiveRecord::Base
  belongs_to :question
  belongs_to :notebook

  has_many :answers
end
