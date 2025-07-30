class CsvUploadJob
  include Sidekiq::Job

  def perform(file_key)
    byebug
    blob = ActiveStorage::Blob.find_by(key: file_key)
    file_path = ActiveStorage::Blob.service.path_for(blob.key)

    CSV.foreach(file_path, headers: true) do |row|
    end
  end
end
