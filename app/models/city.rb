class City < ApplicationRecord
  belongs_to :state, foreign_key: "state_code", primary_key: "code"
end
