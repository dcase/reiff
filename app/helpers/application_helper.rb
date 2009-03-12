# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def textilize_without_paragraph(text)
    textiled = textilize(text)
    if textiled[0..2] == "<p>" then textiled = textiled[3..-1] end
    if textiled[-4..-1] == "</p>" then textiled = textiled[0..-5] end
    return textiled
  end
  
  def super_authorized?(action = action_name, resource = nil)
    if ( authorized?(action, resource) and current_user.group == "superadmin")
      true
    else
      false
    end
  end
  
  def authorized_preview?(action = action_name, resource = nil)
    if ( logged_in? and params[:admin] == "false")
      true
    else
      false
    end
  end
  
end
