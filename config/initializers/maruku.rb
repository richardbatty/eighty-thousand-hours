# For Rails 2.3.3 or later.
# Add a gem dependency on "maruku" with either config.gem or your Gemfile
# (depending on your version of Rails) and then add this file to
# config/initializers/
Markdown = Maruku unless defined?(Markdown)
