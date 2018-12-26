class Climb < ApplicationRecord
  has_one :user
  has_one :grade
  has_one :route
  
  enum performance: [ :attempt, :sent, :flash ]
end
