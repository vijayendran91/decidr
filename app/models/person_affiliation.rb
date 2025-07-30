class PersonAffiliation < ApplicationRecord
  belongs_to :person
  belongs_to :affiliations
end
