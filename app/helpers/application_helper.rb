# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def month_name(month_num)
    MonthList::MONTHS[month_num]
  end
  
  def strip_chars(string='')
    string.gsub(/\s+/,'-').gsub(/[^a-z0-9\-]+/i, '').gsub(/[\-]+/,'-').downcase
  end
  
  def draw_graph(task)
    lists = List.find(:all,
                      :include => :month_list,
                      :conditions => ["lists.complete = ? AND lists.amount IS NOT NULL AND lists.task_id = ?", true, task.id],
                      :order => 'month_lists.year, month_lists.month',
                      :limit => 12)
    
    # don't bother if there isn't enough info for a graph
    return "<p>Not enough info for a graph.</p>" if lists.blank?
    
    # get the task title
    title = task.title.gsub(/\s+/,'+')
    
    # sort the items
    lists = lists.sort_by { |list| "#{list.month_list.year}#{list.month_list.month}" }
    
    # get the amounts of each item
    amounts = lists.map { |i| i.amount }
    
    # collect the month/year labels
    labels = []
    lists.each { |list| labels << "#{list.month_list.month_name[0..2]}+#{list.month_list.year}"}
    
    # we need at least 12 values/labels for the graph to work
    if amounts.length < 13
      (12 - amounts.length).downto(1) do |x|
        amounts.insert(0,0)
        labels.insert(0,'-')
      end
    end
    
    # get the max amount for the range
    max_amount = amounts.sort.last
    
    graph_url = "http://chart.apis.google.com/chart" # base graph url
    graph_url << "?cht=bvs" # set the chart type
    graph_url << "&chs=790x350" # set the chart size
    graph_url << "&chf=bg,s,FFFFFF00" # set the background color to transparent
    graph_url << "&chco=1e9f24" # set the color of the bars
    graph_url << "&chtt=#{title}&chts=8e8e8a,28" # set the chart title
    graph_url << "&chbh=39,25,25" # set the bar width and spacing
    graph_url << "&chxt=x,y" # set the axes
    graph_url << "&chxl=0:|" + labels.join('|') # set the labels for the x-axis
    graph_url << "&chxr=1,0,#{max_amount}" # set the labels for the y-axis
    graph_url << "&chg=10,10" # set the grid lines
    graph_url << "&chd=t:" + amounts.join(",") # add the data
    
    "<img src=\"#{graph_url}\" alt=\"task graph\" />"
  end
  
  def gravatar_url_for(email='')
    return '' if email.blank?
    require 'digest/md5'
    digested_email = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/#{digested_email}"
  end
end
