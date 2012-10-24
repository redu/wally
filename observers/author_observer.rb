class AuthorObserver < Untied::Consumer::Observer
  observe :user, :from => :core

  def after_create(model)
    author = Author.new
    author.user_id = model["user"]["id"]
    author.name = model["user"]["first_name"] + " " +
      model["user"]["last_name"]
    author.login = model["user"]["login"]
    author.token = model["user"]["single_access_token"]
    Wall.create(:resource_id => "core:user_#{author.user_id}_home")
    Wall.create(:resource_id => "core:user_#{author.user_id}")
    author.save
  end

  def after_update(model)
    author = Author.find_by(user_id: model["user"]["id"])
  end
end
