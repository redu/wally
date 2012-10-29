class UserObserver < Untied::Consumer::Observer
  observe :user, :from => :core

  def after_create(model)
    author = Author.new
    author = fill_params(author, model)
    Wall.create(:resource_id => "core:user_#{author.user_id}_home")
    Wall.create(:resource_id => "core:user_#{author.user_id}")
    Entity.create(name: author.name, :entity_id => author.user_id,
                  api_url: author.api_url, core_url: author.perfil_url,
                  kind: "User")
    author.save
  end

  def after_update(model)
    author = Author.find_by(user_id: model["user"]["id"])
    author = fill_params(author, model)
    author.save
  end

  protected
  def fill_params(author, model)
    author.user_id = model["user"]["id"]
    author.name = model["user"]["first_name"] + " " +
      model["user"]["last_name"]
    author.login = model["user"]["login"]
    author.token = model["user"]["single_access_token"]
    author
  end
end
