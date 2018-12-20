class Climb < ApplicationRecord
  enum performance: [ :attempt, :sent, :flash ]
end
