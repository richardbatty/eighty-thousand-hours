class AttachedImage < ActiveRecord::Base
  # paperclip uploads to on S3
  has_attached_file :image, {
                      :styles => { :original => "1024x768", :large => "600x600", :small => "200x200>" },
                      :path => "/posts/images/:id/:style/:filename"
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_size :image, :less_than => 2.megabytes,
                            :unless => Proc.new {|m| m[:asset].nil?}
  validates_attachment_content_type :upload, :content_type=>['image/jpeg', 'image/png', 'image/gif'],
                                    :unless => Proc.new {|m| m[:image].nil?}

  belongs_to :post
end
