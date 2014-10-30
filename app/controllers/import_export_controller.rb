class ImportExportController < ApplicationController

  layout 'admin_layout'
  before_filter :login_required

  ALL_TABLES = ["TestGroup", "TestGroupOwnership", "Group", "GroupOwnership", "Test", "TestOwnership", "Question", "Answer", "FileInfo", "FileContent", "User", "UserOwnership"]

  def show

  end

  def get_export_data(tables)
    results = []
    tables.each do |table|
      tab_ref = eval("#{table}")
      @items = tab_ref.find(:all)
      @columns = tab_ref.column_names
      results << {:class_name => table, :items => @items, :columns => @columns}
    end
    return results
  end

  def xml_export
    case params[:type]
    when "0":
        tables = ALL_TABLES
    when "1":
        tables = ["TestGroup", "TestGroupOwnership"]
    when "2":
        tables = ["Group", "GroupOwnership"]
    when "3":
        tables = ["Test", "TestOwnership", "Question", "Answer", "FileInfo", "FileContent"]
    when "4":
        tables = ["User", "UserOwnership"]
    end
    @data = self.get_export_data(tables)
    if @data.nil? or @data.blank?
      flash[:error] = "Błędny parametr lub brak danych"
      redirect_to :action => "show"
    else
      render :layout => false
      response.headers["Content-Type"] = "application/xml; charset=utf-8"
    end
  end

  def import_to_database(data)
    @import_stats = {:tables => [], :rows_ok => [], :rows_bad => []}
    data["db_data"]["table"].each do |table|
      cname_san = table["class_name"].to_str.delete("^a-zA-Z")
      if ALL_TABLES.include?(cname_san)
        class_ref = eval("#{cname_san}")
        @import_stats[:tables] << cname_san
        @tmp_ok = 0
        @tmp_bad = 0

        if (!table["data"].nil?)

          if (table["data"]["data_row"].class.name == "Array")
            table["data"]["data_row"].each do |item_params|
              item = class_ref.new do |item_|
                item_params.each do |ip|
                  item_[ip[0]] = ip[1]
                end
              end
              begin
                item.save ? (@tmp_ok += 1) : (@tmp_bad += 1)
              rescue
                @tmp_bad += 1
              end
            end
          else
            item = class_ref.new do |item_|
              table["data"]["data_row"].each do |param|
                item_[param[0]] = param[1]
              end
            end
            begin
              item.save ? (@tmp_ok += 1) : (@tmp_bad += 1)
            rescue
              @tmp_bad += 1
            end
          end

        end

      else
        raise "Odniesienie do nieistniejącej tabeli"
      end
      @import_stats[:rows_ok] << @tmp_ok
      @import_stats[:rows_bad] << @tmp_bad
    end
    return @import_stats
  end

  def xml_import
    data_hash = Hash.from_xml(params[:attachment].read)
    import_stats = self.import_to_database(data_hash)
    flash[:notice] = "Zaimportowano dane z pliku <br /><ul>"
    import_stats[:tables].each_with_index do |item, index|
      flash[:notice] << "<li>Tabela: #{item}, dodane rekordy: #{import_stats[:rows_ok][index]}, odrzucone rekordy: #{import_stats[:rows_bad][index]}</li>"
    end
    flash[:notice] << "</ul>"
  rescue Exception => e
    flash[:error] = "Nie udało się przetworzyć pliku. Możliwe, że jest uszkodzony lub nastąpil błąd w przesyłaniu.<br />#{e.message}"
  ensure
    redirect_to :action => 'show'
  end

end
