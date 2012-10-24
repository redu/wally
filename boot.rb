$:.unshift './app/models', './app/representers', './app/apis'

# models
require "ability"
require "entry"
require "answer"
require "author"
require "entity"
require "post"
require "role"
require "wall"

# representers
require "role_representer"
require "author_representer"
require "answer_representer"
require "post_representer"
require "wall_representer"

# apis
require "walls"
require "wally"
require "posts"
require "answers"
