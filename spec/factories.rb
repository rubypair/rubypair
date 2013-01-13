FactoryGirl.define do 
  factory :user do
    sequence(:name){ |n| "Foo Bar #{n}" }
    sequence(:github_login){ |n| "foobar#{n}" }
    sequence(:email){ |n| "foo#{n}@example.com" }
    sequence(:blog_url){ |n| "http://foobar#{n}.tumblr.com" }
    sequence(:gravatar_id){ |n| n.to_s }
    location "Not in Portland, OR"
    remote_local_preference "Both"
    interests "ruby,rails,rubypair"
    sequence(:twitter){ |n| "foo#{n}" }
    last_available_time nil

    factory :available_user do
      last_available_time { Time.now }
    end
  end
end
