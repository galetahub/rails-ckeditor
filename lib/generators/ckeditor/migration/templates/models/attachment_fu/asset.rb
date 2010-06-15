class Ckeditor::Asset < ActiveRecord::Base
  set_table_name "ckeditor_assets"
  
  belongs_to :user
  belongs_to :assetable, :polymorphic => true
  
  scope :masters, where("parent_id IS NULL")
  
  def url(*args)
    public_filename(*args)
  end
  
  def format_created_at
    I18n.l(self.created_at, :format=>"%d.%m.%Y %H:%M")
  end
  
  def to_xml(options = {})
    xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])

    xml.tag!(self.read_attribute(:type).to_s.downcase) do
      xml.filename{ xml.cdata!(self.filename) }
      xml.size self.size
      xml.path{ xml.cdata!(self.public_filename) }
      
      xml.thumbnails do
        self.thumbnails.each do |t|
          xml.tag!(t.thumbnail, self.public_filename(t.thumbnail))
        end
      end unless self.thumbnails.empty?
    end
  end
end
