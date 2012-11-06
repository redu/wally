# -*- encoding : utf-8 -*-
$:.unshift File.dirname(__FILE__)

require 'bundler/setup'
require 'grape'
require 'mongoid'
require 'json'

require 'config/config'

%w(app/models app/representers app/apis).each do |dir|
  $:.unshift "#{WallyConfig.config.root}/#{dir}"
end

# models
require 'ability'
require 'entry'
require 'answer'
require 'author'
require 'entity'
require 'post'
require 'role'
require 'wall'

# representers
require 'entity_representer'
require 'role_representer'
require 'author_representer'
require 'answer_representer'
require 'post_representer'
require 'wall_representer'

# apis
require 'walls'
require 'wally'
require 'posts'
require 'answers'

