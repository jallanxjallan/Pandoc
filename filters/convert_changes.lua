local comment_id = 0

function format_comment(el, ct)
  comment_id = comment_id + 1
  start = pandoc.Span(pandoc.Strong(comment))
  start.attr = {class='comment-start', id=comment_id, author="Jeremy", date="2020-11-25T09:42:33Z"}
  finish=pandoc.Span('')
  finish.attr = {class='comment-end', id=comment_id}
  new = {}
  table.insert(new, start)
  table.insert(new, pandoc.Str(ct))
  table.insert(new, finish)
  return new
end

function Span(elem)
  content = pandoc.utils.stringify(elem.content)

  for k, v in pairs(elem.classes) do
    if v == 'paragraph-insertion' then
      return pandoc.Link(content, 'insertion')
    elseif v == 'insertion' then
      return pandoc.Link(content, 'insertion')
    elseif v == 'deletion' then
      return pandoc.Link(content, 'deletion')
    else
      return elem
    end
  end
end
