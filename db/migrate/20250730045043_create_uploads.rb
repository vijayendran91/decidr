class CreateUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :uploads do |t|

      t.timestamps
    end
  end
end
