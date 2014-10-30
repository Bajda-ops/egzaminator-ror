# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def embed_movie_player(filepath, width='700', height='450')
    return "<object data=\"/AkamaiFlashPlayer.swf\" name=\"myPlayer\" id=\"myPlayer\" type=\"application/x-shockwave-flash\" height=\"#{height}\" width=\"#{width}\">
              <param value=\"true\" name=\"allowFullScreen\">
              <param value=\"src=#{filepath}&amp;autostart=false&amp;themeColor=0395d3&amp;mode=sidebyside&amp;scaleMode=fit&amp;frameColor=333333&amp;fontColor=cccccc&amp;link=&amp;embed=\" name=\"flashvars\">
            </object>"
  end

  def embed_music_player(filepath, titles)
    return "<object type=\"application/x-shockwave-flash\" data=\"/player_mp3_multi.swf\" width=\"200\" height=\"100\">
              <param name=\"movie\" value=\"/player_mp3_multi.swf\" />
              <param name=\"bgcolor\" value=\"#ffffff\" />
              <param name=\"FlashVars\" value=\"mp3=#{filepath}&amp;title=#{titles}\" />
           </object>"
  end

  def image_gallery(test_id)
    @images = FileInfo.find_all_by_test_id_and_ext(test_id, ["image/jpeg", "image/gif"], :order => "id ASC")
    images_links = ""
    @images.each do |file|
      name = (file.owner_type == "q" ? "Pytanie #{file.question_id}" : "Odpowiedź #{file.answer_id}")
      images_links << "<a href=\"/file/show/#{file.id}\" rel=\"lightbox[test_images]\" title=\"#{name}\">#{image_tag("/file/show_small/" + file.id.to_s)}</a>\n"
    end
    return images_links
  end

  def multimedia_bar(params = nil)

    if params.nil?
      flash[:error] = "Brak parametru"
    else
      if ((controller.controller_name == 'test') and (controller.action_name == 'edit'))
          @audio = FileInfo.find_all_by_test_id_and_ext(params[:id], "audio/mpeg", :order => "id ASC")
          audio_path = ""
          titles = ""
          @audio.each do |file|
            audio_path << "/file/show/#{file.id}|"
            titles << (file.owner_type == "q" ? "Pytanie #{file.question_id}|" : "Odpowiedź #{file.answer_id}|")
          end
          audio_path.chomp!('|')
          titles.chomp!('|')
 
          video_path = "http://localhost:3000" + url_for(:controller => 'test', :action => 'rss_playlist', :id => params[:id])

           return "<div class=\"media_bar\">
                      <div class=\"media_bar_bgtop\">
                          <div class=\"media_bar_bgbtm\">
                              <div class=\"title\">
                                  <h2 id=\"mbar_hdr\" onclick=\"slide_js('wrapper2');\">Multimedia</h2>
                              </div>
                              <div id=\"wrapper2\" style=\"display: none;\">
                                  <div class=\"entry\" id=\"mbar_info_content\">
                                      #{self.embed_music_player(audio_path,titles)}
                                      #{self.embed_movie_player(video_path, 560, 315)}
                                      #{self.image_gallery(params[:id])}
                                  </div>
                              </div>

                          </div>
                      </div>
                   </div>"
      end
    end
  end

  def cms_post(title="", content="")
    return "<div class=\"post\">
              <div class=\"post-bgtop\">
                <div class=\"post-bgbtm\">
                  <h2 class=\"title\">#{title}</h2>
                  <div class=\"entry\">#{content}</div>
                </div>
              </div>
            </div>"
  end

  def err_info_field(notice=nil, errors=nil)
    notice.nil? ? notice = "" : notice
    errors.nil? ? errors = "" : errors
    return "<div class=\"err_info\">
              <div class=\"err_info_bgtop\">
                <div class=\"err_info_bgbtm\">
                  <div class=\"title\">
                    <h2 id=\"erri_hdr\" onclick=\"slide_js('wrapper');\">Błędy i informacje</h2>
                  </div>

                  <div id=\"wrapper\"  style=\"display: none;\">
                  <div class=\"entry\" id=\"err_info_content\">
                    <div class=\"error\">
                      #{errors}
                    </div>
                    <div class=\"notice\">
                      #{notice}
                    </div>
                  </div>
                  </div>

                </div>
              </div>
            </div>"
  end

end
