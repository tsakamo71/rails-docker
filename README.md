## 手順
1. bundle exec rails new ./ -B -d postgresql --skip-turbolinks --skip-test
2. rails webpacker:install
3. bundle exec rake db:setup
4. rails s -b 0.0.0.0
