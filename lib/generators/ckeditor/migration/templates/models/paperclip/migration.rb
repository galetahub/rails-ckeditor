class CreateCkeditorAssets < ActiveRecord::Migration
  def self.up
    create_table :ckeditor_assets do |t|
      t.string  :data_file_name, :null => false
      t.string  :data_content_type
      t.integer :data_file_size
      
      t.integer :assetable_id
		  t.string  :assetable_type, :limit => 30
      t.string  :type, :limit => 25
      t.string  :guid, :limit => 10
		  
		  t.integer :locale, :limit => 1, :default => 0
		  t.integer :user_id
		  
      # Uncomment	it to save images dimensions, if your need it
#		  t.integer :width
#		  t.integer :height
		  
      t.timestamps
    end
    
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
		add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
		add_index "ckeditor_assets", ["user_id"], :name => "fk_user"
  end

  def self.down
    drop_table :ckeditor_assets
  end
end
