class Admin < ActiveRecord::Base
  attr_accessible :displayName, :dukeId, :netid
  
  def Admin.fromEPPN(eppn)
    parts = eppn.split('@')
    if(parts[1].eql?('duke.edu'))
      return self.find_by_netid(parts[0])
    else
      return nil
    end
  end
  
end
