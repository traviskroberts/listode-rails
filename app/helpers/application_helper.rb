# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def month_name(month_num)
    MonthList::MONTHS[month_num]
  end
  
  def strip_chars(string='')
    string.gsub(/\s+/,'-').gsub(/[^a-z0-9\-]+/i, '').gsub(/[\-]+/,'-').downcase
  end
  
  def monthly_spending_graph(month_lists=[])
    # don't bother if there isn't enough info for a graph
    return "" if month_lists.blank?
    
    labels = []
    amounts = []
    
    # we only need that last 12 entries (if there are more than that)
    if month_lists.length > 12
      month_lists = month_lists.reverse[0..11].reverse
    end
    
    month_lists.each do |month_list|
      labels << "#{month_list.month_name[0..2]}+#{month_list.year}"
      amounts << month_list.lists.sum(:amount)
    end
    
    # we need at least 12 values/labels for the graph to work
    if amounts.length < 13
      (12 - amounts.length).downto(1) do |x|
        amounts.insert(0,0)
        labels.insert(0,'-')
      end
    end
    
    # get the max amount for the range
    max_amount = amounts.sort.last
    
    # add a little extra room at the top
    max_amount += (max_amount / 10).ceil
    
    graph_url = "http://chart.apis.google.com/chart"                    # base graph url
    graph_url << "?cht=bvs"                                             # set the chart type
    graph_url << "&chs=790x350"                                         # set the chart size
    graph_url << "&chf=bg,s,FFFFFF00"                                   # set the background color to transparent
    graph_url << "&chco=1e9f24"                                         # set the color of the bars
    graph_url << "&chtt=Total+Spending+(last+12+months)&chts=8e8e8a,28" # set the chart title
    graph_url << "&chbh=39,25,25"                                       # set the bar width and spacing
    graph_url << "&chxt=x,y"                                            # set the axes
    graph_url << "&chds=0,#{max_amount}"
    graph_url << "&chxl=0:|" + labels.join('|')                         # set the labels for the x-axis
    graph_url << "&chxr=1,0,#{max_amount}"                              # set the labels for the y-axis
    graph_url << "&chm=N*cUSD2*,555555,0,-1,12"                         # set the labels for each bar
    graph_url << "&chg=10,10"                                           # set the grid lines
    graph_url << "&chd=t:" + amounts.join(",")                          # add the data
    
    "<img src=\"#{graph_url}\" alt=\"overall graph\" />"
  end
  
  def draw_graph(task)
    lists = List.find(:all,
                      :include => :month_list,
                      :conditions => ["lists.complete = ? AND lists.amount IS NOT NULL AND lists.task_id = ?", true, task.id],
                      :order => 'month_lists.year, month_lists.month')
    
    # don't bother if there isn't enough info for a graph
    return "<p>Not enough info for a graph.</p>" if lists.blank?
    
    # get the task title
    title = task.title.gsub(/\s+/,'+')
    
    # we only need that last 12 entries (if there are more than that)
    if lists.length > 12  
      lists = lists.reverse[0..11].reverse
    end
    
    # get the amounts of each item
    amounts = lists.map { |i| i.amount }
    
    # collect the month/year labels
    labels = []
    lists.each { |list| labels << "#{list.month_list.month_name[0..2]}+#{list.month_list.year}"}
    
    # we need at least 12 values/labels for the graph to work
    if amounts.length < 12
      (12 - amounts.length).downto(1) do |x|
        amounts.insert(0,0)
        labels.insert(0,'-')
      end
    end
    
    # get the max amount for the range
    max_amount = amounts.sort.last
    
    # add a little extra room at the top
    max_amount += (max_amount / 10).ceil
    
    graph_url = "http://chart.apis.google.com/chart"  # base graph url
    graph_url << "?cht=bvs"                           # set the chart type
    graph_url << "&chs=790x350"                       # set the chart size
    graph_url << "&chf=bg,s,FFFFFF00"                 # set the background color to transparent
    graph_url << "&chco=1e9f24"                       # set the color of the bars
    graph_url << "&chtt=#{title}+(last+12+months)&chts=8e8e8a,28"      # set the chart title
    graph_url << "&chbh=39,25,25"                     # set the bar width and spacing
    graph_url << "&chxt=x,y"                          # set the axes
    graph_url << "&chds=0,#{max_amount}"
    graph_url << "&chxl=0:|" + labels.join('|')       # set the labels for the x-axis
    graph_url << "&chxr=1,0,#{max_amount}"            # set the labels for the y-axis
    graph_url << "&chm=N*cUSD2*,555555,0,-1,12"       # set the labels for each bar
    graph_url << "&chg=10,10"                         # set the grid lines
    graph_url << "&chd=t:" + amounts.join(",")        # add the data
    
    "<img src=\"#{graph_url}\" alt=\"task graph\" />"
  end
  
  def gravatar_url_for(email='')
    return '' if email.blank?
    require 'digest/md5'
    digested_email = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/#{digested_email}"
  end
end
