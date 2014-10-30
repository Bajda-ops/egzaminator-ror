module TestHelper

  def question_hlp(question, active_test_id)
    if question.blank?
      result = ""
    else
      case question.question_type.name
      when "Pojedynczego wyboru" then
        result = ""
        question.answers("ord_id ASC").each do |ans|
          result << "<p>#{radio_button_tag("answer[]", ans.id, ans.choosen?(current_user.id, active_test_id))} #{ans.tekst}</p>"
        end
        result << hidden_field_tag("active_test_id",  active_test_id)
        result << hidden_field_tag("question_ord_id",  question.ord_id)
      when "Wielokrotnego wyboru" then
        result = ""
        question.answers("ord_id ASC").each do |ans|
          result << "<p>#{check_box_tag("answer[]", ans.id, ans.choosen?(current_user.id,active_test_id))} #{ans.tekst}</p>"
        end
        result << hidden_field_tag("active_test_id",  active_test_id)
        result << hidden_field_tag("question_ord_id",  question.ord_id)
      else
        flash[:error] = "Błędny typ pytania"
        result = ""
      end
    end
    return result
  end
  
end

