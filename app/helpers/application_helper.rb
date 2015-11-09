module ApplicationHelper
  def pbar(step)
    ret = ''
    steps = [{"one"=>"Contact"}, {"two"=>"Project"}, {"three"=>"Server"}, {"four"=>"Agreement"}, {"five"=>"Finish"}]
    (0..steps.size-1).each do |i|
      ret<< "<li id='#{steps[i].keys.first}'"
      if i<step
        ret<< ' class="complete"'
      elsif i==step
        ret<< 'class="current"'
      end
      ret<< "><div class='stepnum'><p>#{i+1}</p></div><div class='stepname'>#{steps[i].values.first}</div></li>\n"
    end
    ret.html_safe
  end
    
end
