

def findElement text

  soruce = page.html
  cond = soruce.split(text)
  if cond.count == 2

    tag = cond[0].split("<").last
    tag = tag.split[0]

    if cond[0][cond[0].length - 1] == '"'
      attr = cond[0].split('<').last
      attr = attr.split('="').last
      attr = attr.split.last
      return find(:xpath, "//#{tag}[@#{attr}='#{text}']", visible: true)
    else
      attr = cond[0].split("<").last
      unless attr.include? "=\""
        return  find(:xpath, "//#{tag}[contains(text(),'#{text}')]", visible: true)
      else
        attr = attr.split[1]
        attr = attr.split('>')[0]
        return find(:xpath, "//#{tag}[@#{attr}][contains(text(),'#{text}')]", visible: true)
      end
    end
  else

    attr_name = ['name', 'id', 'class', 'href', 'title', 'type', 'placeholder','value', 'list', 'dropzone', 'draggable', 'download', 'form', 'headers']
    i = 0
    attr_name.each do |attribute|
      @element = attribute + '="' + text + '"'
      break if soruce.include? @element
      i += 1
      next if i < attr_name.count
      raise('could not find :'+@element)
    end
    return find(:xpath, "//*[@#{@element}]", visible: true)

  end


end