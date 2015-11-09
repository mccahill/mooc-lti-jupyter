class LdapTool
  require 'net/ldap'

  def LdapTool.userLookup(searchStr)
    return nil if searchStr.blank?

    attrs = ["displayName", "uid"]
    ldap_con = Net::LDAP.new(:host => "ldap.duke.edu",
                              :port => 636,
                              :encryption => :simple_tls,
                              :auth => {:method => :anonymous})
    a = Net::LDAP::Filter.eq('edupersonaffiliation','student')
    b = Net::LDAP::Filter.eq('edupersonaffiliation','staff')
    c = Net::LDAP::Filter.eq('edupersonaffiliation','faculty')
    d = Net::LDAP::Filter.eq('edupersonaffiliation','emeritus')

    if !/ /.match(searchStr)     # Single word case
      searchStr.concat "*"
      j = Net::LDAP::Filter.eq('uid', searchStr)
      k  = Net::LDAP::Filter.eq('givenname', searchStr)
      l  = Net::LDAP::Filter.eq('cn', searchStr)
      m  = Net::LDAP::Filter.eq('sn', searchStr)
      op_filter = (k|l|j|m)   #match netid firstname or nickname and their last name
    else
      words = searchStr.split(" ")
      words.each do | word|
        word.concat("*") if (/\*/.match(word)).nil?
      end
      k  = Net::LDAP::Filter.eq('givenname', words[0])
      l  = Net::LDAP::Filter.eq('cn', "#{words[0]} #{words[1]}")
      op_filter = (k|l)
      op_filter  = (op_filter & Net::LDAP::Filter.eq('sn', words[words.size - 1])) if words.size>1
    end

    op_filter = (a|b|c|d) & op_filter
    retArray = {}
    Rails.logger.info("search is: #{op_filter}")
    ldapArray = ldap_con.search( :base => "OU=people,DC=duke,DC=edu", :filter => op_filter, :size=>15, :return_result=>false) do |e|

      if e.attribute_names.include?(:uid)
        name = e.attribute_names.include?(:displayname) ? "#{e.displayname.first} (#{e.uid.first})" : e.uid.first
        retArray[e.uid.first] = name
      end

    end
    return retArray
  end
  
  def LdapTool.createUser(netid)
    attrs = ["displayName", "uid", "dudukeid",'telephonenumber','mail']
    ldap_con = Net::LDAP.new(:host => "ldap.duke.edu",
                              :port => 636,
                              :encryption => :simple_tls,
                              :auth => {:method => :anonymous})
    op_filter = Net::LDAP::Filter.construct("uid=#{netid}")
    ldapArray = ldap_con.search( :base => 'OU=people,DC=duke,DC=edu', :filter => op_filter, :attrs=>attrs, :return_result=>true)
    return nil if ldapArray.blank? or ldapArray.size >1

    anames = ldapArray.first.attribute_names
    u = User.new
    u.netid = anames.include?(:uid) ? ldapArray.first.uid.first : nil
    u.displayName = anames.include?(:displayname) ? ldapArray.first.displayname.first : 'Missing'
    u.duid = anames.include?(:dudukeid) ? ldapArray.first.dudukeid.first : 'Missing'
    u.phone = anames.include?(:telephonenumber) ? ldapArray.first.telephonenumber.first : 'Missing'
    u.email = anames.include?(:mail) ? ldapArray.first.mail.first : 'Missing'
    u.save
    return u

  end
end