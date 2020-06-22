function Smallcaps(elem)
    if question = string.gsub(elem.text,'<!--', 'question:') then
      return elem.text
    end
end
