module ApplicationHelper
  def thumbs(boolean)
      if boolean
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
