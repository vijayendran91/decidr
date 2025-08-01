class CsvUploadJob
  include Sidekiq::Job

  def perform(file_key, upload_id)
    blob = ActiveStorage::Blob.find_by(key: file_key)
    file_path = ActiveStorage::Blob.service.path_for(blob.key)
    CSV.foreach(file_path, headers: true) do |row|
      affilation_names = format_affiliations(row["Affiliations"])
      person = nil
      unless affilation_names.empty?
        person = save_person(row)
        affilation_names.each do |name|
          affiliation = Affiliation.find_or_create_by(name: name)
          unless person.nil?
            person.affiliations << affiliation unless person.affiliations.exists?(affiliation.id)
          end
        end
      end

      locations = format_locations(row["Location"])
      locations.each do |location_name|
        location = Location.find_or_create_by(name: location_name.capitalize)
        unless person.nil?
          person.locations << location unless person.locations.exists?(location.id)
        end
      end
    end
    Upload.find(upload_id).destroy!
  end

  private

  def format_names(names)
    names = names.split(" ")
    names.map! { |name| name.capitalize }
  end

  def format_affiliations(affiliations)
    affiliations.nil? ? [] : affiliations.split(",")
  end

  def format_locations(locations)
    locations.split(",")
  end

  def format_gender(gender)
    case gender.to_s.strip.downcase
    when "m", "male"
      "Male"
    when "f", "female"
      "Female"
    else
      "Other"
    end
  end

  def save_person(row)
    names = format_names(row["Name"])
    person = Person.find_or_initialize_by(first_name: names[0])
    if person.new_record?
      person.last_name = names[1..].join(" ") unless names[1].nil?
      person.species = row["Species"]
      person.gender = format_gender(row["Gender"])
      person.weapon = row["Weapon"]
      person.vehicle = row["Vehicle"]
      person.save!
    end
    person
  end
end
