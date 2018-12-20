class Grade < ApplicationRecord
  enum system: [ :yds, :vscale ]
  enum climb_type: [ :bouldering, :sport ]
end
