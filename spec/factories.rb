Factory.define :user do |f|
  f.sequence(:name){ |n| "Foo Bar #{n}" }
  f.sequence(:github_login){ |n| "foobar#{n}" }
  f.sequence(:email){ |n| "foo#{n}@example.com" }
  f.sequence(:blog_url){ |n| "http://foobar#{n}.tumblr.com" }
  f.sequence(:gravatar_id){ |n| n.to_s }
  f.location "Not in Portland, OR"
  f.remote_local_preference "Both"
  f.interests "ruby,rails,rubypair"
  f.sequence(:twitter){ |n| "foo#{n}" }
  f.last_available_time nil
end
