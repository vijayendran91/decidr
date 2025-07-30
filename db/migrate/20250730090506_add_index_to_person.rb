class AddIndexToPerson < ActiveRecord::Migration[8.0]
  def change
    add_index :people, :first_name, unique: true
    add_index :person_affiliations, [ :person_id, :affiliation_id ], unique: true, name: "index_person_affiliations"
    add_index :person_locations, [ :person_id, :location_id ], unique: true, name: "index_person_locations"
  end
end
