class UploadController < ApplicationController
  def home
  end

  def upload
    # Can be uploaded to Amazon S3 or ActiveStorage
    @upload = Upload.new(file: upload_params)
    if @upload.save!
      CsvUploadJob.perform_async(@upload.file.blob.key)
      # redirect_to upload_success_path, notice: "Upload queued for processing"
    end
  end

  def success
  end


  private

  def upload_params
    params.require(:file)
  end
end
