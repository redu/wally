FactoryGirl.define do
  factory :post do
    created_at Date.today
    content({ text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do." })
    context([
      { id: 1, name: "Curso Tal", links: [ {rel: "self", href: "http://redu.com.br/api/courses/12"}, {rel: "public_self", href: "http://redu.com.br/environment/cursos/curso-de-algo"} ]},
      { id: 1, name: "Curso Tal", links: [ {rel: "self", href: "http://redu.com.br/api/courses/12"}, {rel: "public_self", href: "http://redu.com.br/environment/cursos/curso-de-algo"} ]}])
    target_on({ id: 12, name: "Disciplina Tal",
    links:[ {rel: "self", href:"http://redu.com.br/api/spaces/2121"},
            {rel: "self_public", href:"http://redu.com.br/espacos/2121" }]})
    action "comment"
    rule({manage: true})
  end
end
