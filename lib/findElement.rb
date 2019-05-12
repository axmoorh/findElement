=begin

@example:
 <div class="container pos-rl">
                        <div id="MastheadBannerShowHide" class="hidden hidden-m">
                            <div class="content">Hidden subject</div>
                            <div class="background"></div>
                            <div class="border"></div>
                        </div>
                    </div>
                    <span aria-label="Button busy" class="adv-spinner loadingSpinner" role="img">picture</span>
                    <div id='div-gpt-ad-1455279154558-0' class="mastheadBanner text-center hidden-m"></div>
                    <div id='div-gpt-ad-1459260874003-0' class="mastheadBanner text-center visible-m"></div>
                </div>

findElement("Hidden subject")["class"]  ==> content

findElement("div-gpt-ad-1455279154558-0").click  ==>click element

findElement("adv-spinner loadingSpinner").text ==> picture





=end


def findElement text


  begin
    Timeout.timeout(2) do
      return find(:xpath, "//*[contains(text(),'#{text}')]", visible: true)
    end
  rescue
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
          return find(:xpath, "//#{tag}[contains(text(),'#{text}')]", visible: true)
        else
          key = attr.split('="')[0].split[1]
          value = attr.split(key)[1].split('"')[1]
          return find(:xpath, "//#{tag}[@#{key}='#{value}'][contains(text(),'#{text}')]", visible: true)
        end
      end
    else

      attr_name = ['name', 'id', 'class', 'href', 'data-title', 'data-dismiss', 'style', 'title', 'type', 'placeholder', 'value', 'list', 'dropzone', 'draggable', 'download', 'form', 'headers']
      i = 0
      attr_name.each do |attribute|
        @element = attribute + '="' + text + '"'
        break if soruce.include? @element
        i += 1
        next if i < attr_name.count
        raise('could not find :' + @element)
      end
      return find(:xpath, "//*[@#{@element}]", visible: true)
    end

  end


end
