$:.unshift './app/representers', './app/models'
require "role_representer"
require "author_representer"
require "answer_representer"
require "post_representer"
require "wall_representer"
require "ability"
require "entry"
require "answer"
require "author"
require "entity"
require "post"
require "role"
require "wall"
Mongoid.load!("./config/mongoid.yml", :development)

# user: {"links":{"href":"http://0.0.0.0:3000/pessoas/julianalucena","rel":"public_self"},"name":"Juliana Lucena","thumbnails":{"href":"0.0.0.0:3000/images/new/missing_users_thumb_32.png","size":"32x32"},"user_id":"8"},
#                   target: {"id":"522","kind":"space","links":{"href":"http://0.0.0.0:3000/espacos/522","rel":"self_public"},"name":"Matemática"},
#                   contexts: [{"id":"415","links":{"href":"http://0.0.0.0:3000/escola-redu-amostra","rel":"self_public"},"name":"Escola Redu Amostra"},{"id":"461","links":{"href":"http://0.0.0.0:3000/escola-redu-amostra/cursos/sexto-ano-do-ensino-fundamental-turma-a-2012","rel":"self_public"},"name":"Sexto Ano do Ensino Fundamental Turma A 2012"}]

author = Author.new(name: "Juliana Lucena", login: "julianalucena",
                    user_id: 8,
                    perfil_url: "http://0.0.0.0:3000/pessoas/julianalucena",
                    api_url: "http://0.0.0.0:3000/api/users/8", token: "cooltoken")

author.thumbnails = [{href:"0.0.0.0:3000/images/new/missing_users_thumb_32.png", size:"32x32"}]
author.role = Role.new(name: "tutor",
                       thumbnail: { address: "http://s3.amazonaws.com/redu_uploads/users/avatars/4/thumb_32/Guilherme3x4%20copy.jpg?1323711306",
                                     size: "32x32"})
author.save

entity1 = Entity.new(name: "Curso tal", entity_id: 2121,
                    api_url: "http://redu.com.br/api/spaces/2121",
                    core_url: "http://redu.com.br/espacos/2121")
entity1.save

entity2 = Entity.new(name: "Ivanete Ferreira", entity_id: 5790,
                    api_url: "http://redu.com.br/api/spaces/2121",
                    core_url: "http://localhost:3000/pessoas/ivanete_van")
entity2.save

wall = Wall.new(resource_id: "core:space_1")
wall.save

post = Post.new(origin_wall: wall.resource_id, created_at: DateTime.now,
                content: {text: "Teste"},
                action: "comment",
                links: [ { rel: "self",
                           href: "http://wally.redu.com.br/posts/1" } ])
post.target_on = entity1
post.walls << wall
post.author = author
post.contexts << entity1
post.contexts << entity2
post.save


answer = Answer.new(created_at: DateTime.now,
                    content: {text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "})
answer.author = author
answer.post = post
answer.save

ability = Ability.new(Author.first)
wall = Wall.first
wall.define_rule(ability, author)
