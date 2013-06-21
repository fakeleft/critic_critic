module ApplicationHelper

  def thumbs(boolean)
    boolean = boolean.to_s
      if boolean == "true"
        class_select = "icon-thumbs-up"
      else
        class_select = "icon-thumbs-down"
      end
      return { class: "#{class_select}" }
  end


  # Generates dynamic page titles and headers
  def title(page_title)
    content_for :title do
      page_title
    end
  end
end
