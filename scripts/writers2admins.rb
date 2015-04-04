tech_writers = ["isaac.eldridge@puppetlabs.com",
                "jorie@puppetlabs.com",
                "mike.hall@puppetlabs.com",
                "nick.fagerlund@puppetlabs.com",
                "jean@puppetlabs.com",
                "michelle.fredette@puppetlabs.com",
                "pete@puppetlabs.com"]

tech_writers.each do |w|
  if user = User.find_by_email(w)
    user.admin = true
    user.save
  end
end
                
