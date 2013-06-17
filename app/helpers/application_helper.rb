module ApplicationHelper
  def thumbs(boolean)
      if boolean
        class_select = "icon-thumbs-up"
      else
        class_select = "icon-thumbs-down"
      end
      return { class: "#{class_select}" }
  end
end
