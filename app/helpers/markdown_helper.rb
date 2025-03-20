module MarkdownHelper
  def markdown_to_html(text)
    renderer = Redcarpet::Render::HTML.new(
      link_attributes: { target: '_blank' },
      space_after_headers: true
    )
    html_content = Redcarpet::Markdown.new(renderer, autolink: true).render(text)
    sanitize(html_content)
  end
end
