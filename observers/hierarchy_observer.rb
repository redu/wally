class HierarchyObserver < Untied::Consumer::Observer
  observe(:course, :space, :environment, :from => :core)

  def after_create(model)
    kind = model.keys[0]
    entity = Entity.new
    entity = fill_params(entity, model, kind)
    create_wall(entity) if kind == "space"
    entity.save
  end

  def after_update(model)
    kind = model.keys[0]
    entity = Entity.find_by(entity_id: model[kind]["id"])
    entity = fill_params(entity, model, kind)
    entity.save
  end

  protected

  def fill_params(entity, model, kind)
    entity.name = model[kind]["name"]
    entity.entity_id = model[kind]["id"]
    entity.kind = kind
    entity.api_url = "esperando_teste"
    entity.core_url = "esperando_teste"
    entity
  end

  def create_wall(entity)
    Wall.create(resource_id: "core:space_#{entity.entity_id}")
  end
end
