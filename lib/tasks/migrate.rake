
namespace :migrate do
  task :user_prefs => :environment do
    $stdout.sync = true

    User.where(:remote_local_preference => "Both").each do |user|
      user.remote = true
      user.local  = true
      user.unset(:remote_local_preference)
      user.save!

      $stdout.print "."
    end

    User.where(:remote_local_preference => "Local").each do |user|
      user.remote = false
      user.local  = true
      user.unset(:remote_local_preference)
      user.save!

      $stdout.print "."
    end

    User.where(:remote_local_preference => "Remote").each do |user|
      user.remote = true
      user.local  = false
      user.unset(:remote_local_preference)
      user.save!

      $stdout.print "."
    end


    $stdout.print "\nDone\n"
  end
end
