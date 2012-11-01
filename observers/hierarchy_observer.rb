class HierarchyObserver < Untied::Consumer::Observer
  observe(:course, :space, :environment, :from => :core)

  def after_create(model)
    kind = model.keys[0]
    entity = Entity.new
    entity = fill_params(entity, model, kind)
    Wall.create(resource_id: "core:#{kind}_#{entity.entity_id}")
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
end
