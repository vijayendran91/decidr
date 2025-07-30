class Person < ApplicationRecord
  has_many :person_affiliations, dependent: :destroy
  has_many :affiliations, through: :person_affiliations

  has_many :person_locations, dependent: :destroy
  has_many :locations, through: :person_locations

  validates_presence_of :first_name

  # validate :must_have_one_valid_affiliation


  # def must_have_one_valid_affiliation
  #   if affiliations.empty?
  #     errors.add(:affiliations, "must include at least one")
  #   end
  # end
end
