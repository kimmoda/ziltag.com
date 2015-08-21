# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.paths.concat [
  'vendor/assets/components',
].concat Dir['vendor/assets/components/**/*/fonts']

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w[
  admin.css admin.js
  embedded.css embedded.js
  embedded/ziltagging.css embedded/ziltagging.js
  landing.css landing.js
]
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|woff2|ttf|gif)\z/