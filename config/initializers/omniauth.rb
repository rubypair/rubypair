Rails.application.config.middleware.use OmniAuth::Builder do
  begin
    APP_CONFIG = YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))
    provider :github, APP_CONFIG['omniauth']['github_id'], APP_CONFIG['omniauth']['github_secret']
  rescue
    provider :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET']
  end
end
