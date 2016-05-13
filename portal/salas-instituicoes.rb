BigbluebuttonRoom.all.order(:name).each do |r|
  if r.owner && !r.owner.disabled?
    print "#{r.meetingid}\t #{r.name}\t "
    print r.owner.institution.name if r.owner.institution
    print "\n"
  end
end
