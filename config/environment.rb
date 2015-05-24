# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Disable Slim Warnings
# Slim::Engine: Option :escape_html is invalid
# Slim::Engine: Option :escape_attrs is invalid

require 'slim'
Slim::Engine.disable_option_validator!

Date::DATE_FORMATS[:default] = "%Y-%m-%d"
Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M"