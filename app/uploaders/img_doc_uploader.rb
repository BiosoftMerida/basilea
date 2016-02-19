# encoding: utf-8

class ImgDocUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::MiniMagick
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"documentos/#{model.document_album.escuela_transporte.razonSocial.gsub(" ","_").mb_chars.normalize(:kd).gsub(/[^x00-\x7F]/n, '').to_s.upcase.gsub(/[^a-zA-Z0-9_-]/,"")}/#{model.document_album.nombre.upcase}/#{model.nombre}"
    model.document_path
  end
  def filename
    @name ||= "#{timestamp}-#{super}" if original_filename.present? and super.present?
  end


  process :resize_to_fit => [2000, 2000], :if =>  :not_pdf?

  version :thumb do
    # process :resize_to_fill => [100,100]
    #process :thumbnail_pdf
    process :cover
    process :resize_to_fill => [80, 80]
    process :convert => :jpg

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + '.jpg'
    end
  end

  def cover
    manipulate! do |frame, index|
      frame if index.zero?
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #éáíöü
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

  def documento_parametro
    return @original_filename
  end
  def set_documento_parametro(file)
    @original_filename = file
  end

  protected
  def not_pdf?(new_file)
    not new_file.content_type.include? 'pdf'
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
