# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

require 'slim'

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :directory_indexes

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

ignore '/images/favicon/*.png'
ignore '/images/favicon/logo.svg'
ignore '*/.keep'

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

data.contests.each do |id, contest|
  proxy "/contest/#{id.to_i}/index.html", "/products.html", locals: {contest: contest}, ignore: true
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

require 'uri'

helpers do
  def image_url(image)
    URI.join(config[:host], "/images/", image.to_s)
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript

  config[:host] = 'https://proconist.net'
end

configure :development do
  config[:host] = 'http://localhost'
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
  deploy.commit_message = "Auto deploy at #{Time.now} [ci skip]"
end
