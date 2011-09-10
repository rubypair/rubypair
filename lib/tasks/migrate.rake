
namespace :migrate do
  task :user_prefs => :environment do
    $stdout.sync = true
    User.where(:remote_local_preference => "Both").each do |user|
      user.remote_local_preference = "Local or Remote"
      user.save!

      $stdout.print "."
    end

    $stdout.print "\nDone\n"
  end
end
