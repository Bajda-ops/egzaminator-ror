require 'RMagick'

class FileController < ApplicationController

  def show
    @attachment = FileInfo.find_by_id(params[:id])
    send_data(@attachment.file_content.content, :type => @attachment.ext, :filename => @attachment.name, :disposition => 'inline')
  end

  def show_small
    @attachment = FileInfo.find_by_id(params[:id])
    picture = Magick::Image.from_blob(@attachment.file_content.content).first
    send_data(picture.scale(100,100).to_blob, :type => @attachment.ext, :filename => @attachment.name, :disposition => 'inline')
  end

end
