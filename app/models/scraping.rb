class Scraping
  def self.poster_urls

    agent = Mechanize.new
    links = []
    next_url = ""
    # yyyymm for target events
    date_url = ["201609", "201610", "201611"]
    # place? need to be analyzed
    place_url = ["/ar0313/"]

    tmp1 = 0
    tmp2 = 0

    while true do
        while true do
            while true do

                current_page = agent.get("http://www.walkerplus.com/event_list/" + date_url[tmp1] + place_url[tmp2] + next_url)
                elements = current_page.search('.content-inner1 .list-box h2 a')
                elements.each do |ele|
                  links <<   ele.get_attribute('href')
                end

                next_link = current_page.at('.list-paging .next a')

                unless next_link
                  break
                end

                next_url = next_link.get_attribute('href')
            end
            tmp1 += 1
            next_url = ""

            unless date_url[tmp1]
              tmp1 = 0
              break
            end

       end
       tmp2 +=1

       unless place_url[tmp2]
          break
       end

    end
        links.each do |link|
          puts get_poster(link)
        end

  end

  def self.get_poster(link)
    tmp = 0
    agent = Mechanize.new
    page = agent.get("http://www.walkerplus.com" + link)
    title = page.at('h1').inner_text if page.at('h1')
    detail = page.at('.text-box .text').inner_text if page.at('.text-box .text')
    image_url = page.at('.img-box .ph-l img')[:src] if page.at('.img-box .ph-l img')
    link_url = "http://www.walkerplus.com" + link
    tableinfos = page.search('.data-table .data-td')
    tabletitles = page.search('.data-table .data-th')
    place = ""
    date  = ""
    time  = ""
    address = ""

    tabletitles.each do |tabletitle|
      case tabletitle.inner_text
      when "開催場所・会場"
        place = tableinfos[tmp].inner_text if tableinfos[tmp].inner_text

      when "開催日・期間"
        date = tableinfos[tmp].inner_text if tableinfos[tmp].inner_text

      when "開催時間"
        time = tableinfos[tmp].inner_text if tableinfos[tmp].inner_text

      when "住所"
        address = tableinfos[tmp].inner_text if tableinfos[tmp].inner_text
      else
      end

    tmp += 1
    end

    poster = Poster.where(title: title).first_or_initialize
    poster.place = place
    poster.address = address
    poster.date = date
    poster.time = time
    poster.image_url = image_url
    poster.link_url = link_url
    poster.detail = detail
    poster.reference = "walkerplus"
    poster.save
  end

##########################################################
####### For Lets Tokyo
##########################################################
  def self.letstokyo_poster_urls

    agent = Mechanize.new
    links = []
    next_url = "/search/event/"
    tmp = 0

    while true do

        current_page = agent.get("http://www.enjoytokyo.jp" + next_url)
        elements = current_page.search('.vevent .onetxt a')
        elements.each do |ele|
          links <<   ele.get_attribute('href')
        end

        next_link = current_page.at('.sort_head_02 .sort_pager .next a')
        puts tmp
        unless next_link && tmp < 30
          break
        end

        next_url = next_link.get_attribute('href')
        tmp += 1
    end
        links.each do |link|
          puts get_letstokyo_poster(link)
        end

  end


  def self.get_letstokyo_poster(link)
    tmp = 0
    agent = Mechanize.new
    page = agent.get("http://www.enjoytokyo.jp" + link)
    title = page.at('#spottitlebox h1').inner_text if page.at('#spottitlebox h1')
    detail = page.at('.pagetitle .title').inner_text if page.at('.pagetitle .title')
    image_url = "http://www.enjoytokyo.jp" + page.at('.firstChild img')[:src] if page.at('.firstChild img')
    link_url = "http://www.enjoytokyo.jp" + link
    tableinfos = page.search('.tablestyle03 td')
    tabletitles = page.search('.tablestyle03 th')
    place = ""
    date  = ""

    tabletitles.each do |tabletitle|
      case tabletitle.inner_text
      when "最寄駅"
        place = tableinfos[tmp].inner_text.gsub(/\s/, '') if tableinfos[tmp].inner_text

      when "日程"
        date = tableinfos[tmp].inner_text.gsub(/\s/, '') if tableinfos[tmp].inner_text

      else
      end

    tmp += 1
    end

    poster = Poster.where(title: title).first_or_initialize
    poster.place = place
    poster.date = date
    poster.image_url = image_url
    poster.link_url = link_url
    poster.detail = detail.gsub(/\s/, '') if detail
    poster.reference = "Let's Tokyo"
    poster.save
  end

end
