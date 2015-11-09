class LtiUserSession < ActiveRecord::Base
  attr_accessible :userEmail, :userId, :username, :action, :notes, :destination
  
  
  def LtiUserSession.log(the_userId, the_username, the_userEmail, the_action, the_notes, the_destination)
    @entry = self.new(:userId=>the_userId, 
      :username=>the_username,
      :userEmail=>the_userEmail,
      :action=>the_action,
      :notes=>the_notes,
      :destination=>the_destination)
    @entry.save
  end
  
end
