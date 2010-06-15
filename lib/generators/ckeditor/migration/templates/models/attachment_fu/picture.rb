class Ckeditor::Picture < Ckeditor::Asset
  has_attachment :content_type => :image, 
                 :storage => :file_system, :path_prefix => 'public/assets/pictures',
                 :max_size => 2.megabytes,
                 :size => 0.kilobytes..2000.kilobytes,
                 :processor => 'Rmagick',
                 :thumbnails => { :content => '575>', :thumb => '100x100!' }
                 
	validates_as_attachment
  
  def url_content
	  public_filename(:content)
	end
	
	def url_thumb
	  public_filename(:thumb)
	end
	
	def to_json(options = {})
	  options[:methods] ||= []
	  options[:methods] << :url_content
	  options[:methods] << :url_thumb
	  super options
  end
end
