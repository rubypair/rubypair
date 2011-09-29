$LOAD_PATH << "."

require 'ostruct'
require 'app/models/user/new_user_provisioner'

describe NewUserProvisioner do
  subject do
    OpenStruct.new.tap do |user|
      @fake_user_info = {
        'name' => 'jsmith',
        'email' => 'jsmith@gmail.com',
        'urls' => {
          'GitHub' => 'http://www.github.com/jsmith',
          'Blog' => 'http://awesomeblog.com',
        }
      }
      @fake_extra_user_hash = {
        'login' => 'jsmith',
        'gravatar_id' => 'other_email@gmail.com',
        'location' => 'someplace'
      }
      user.extend NewUserProvisioner
      user.provision_with(@fake_user_info, @fake_extra_user_hash)
    end
  end

  its(:name) { should == 'jsmith' }
  its(:email) { should == 'jsmith@gmail.com' }
  its(:github_url) { should == 'http://www.github.com/jsmith' }
  its(:github_login) { should == 'jsmith' }
  its(:blog_url) { should == 'http://awesomeblog.com' }
  its(:gravatar_id) { should == 'other_email@gmail.com' }
  its(:location) { should == 'someplace' }
end
