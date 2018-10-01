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
    URI.join("https://proconist.net/", "images", image.to_s)
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
