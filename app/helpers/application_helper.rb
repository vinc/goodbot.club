module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
      fenced_code_blocks: true,
      autolink: true
    })
    markdown.render(text).html_safe
  end

  def wrap(text, prefix: "")
    # text = WordWrap.ww(text, 72)
    text.lines.map { |line| "#{prefix}#{line}" }.join
  end
end
