class TakenTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :test
  has_many :taken_answers, :dependent =>:destroy
  has_and_belongs_to_many :user

  def full_name
    return "#{self.test.name} #{self.created_at}"
  end

  def generate_pdf_results(class_name, item_id)
    if item_id.blank?
      raise "Brak ID użytkownika lub grupy"
    end
    @item = eval(class_name).find(item_id)
    if @item.blank?
      raise "Błędne ID użytkownika lub grupy"
    end
    pdf = PDF::Writer.new
    pdf.select_font "Times-Roman"
    pdf.text "Hello, Ruby.", :font_size => 72, :justification => :center
    return pdf
  end
end
