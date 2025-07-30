class Affiliation < ApplicationRecord
  has_many :person_affiliations, dependent: :destroy
  has_many :people, through: :person_affiliations
end
