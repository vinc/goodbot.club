module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text).html_safe
  end

  def wrap(text)
    WordWrap.ww(text, 72)
  end
end
