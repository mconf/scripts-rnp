print "meetingID\tname\tinstitution\tinstitutionAcronym\n"
BigbluebuttonRoom.all.order(:name).each do |r|
  if r.owner && !r.owner.disabled?
    print "#{r.meetingid}\t#{r.name}\t"
    if r.owner.institution
      print r.owner.institution.name
      print "\t"
      print r.owner.institution.acronym
    else
      print "\t"
    end
    print "\n"
  end
end
