class LectureObserver < Untied::Consumer::Observer
  observe :lecture, :from => :core

  def after_create(model)
    entity = Entity.new
    entity = fill_params(entity, model)
    wall = Wall.create(resource_id: "core:lecture_#{entity.entity_id}")
    wall.reference_walls << space_wall(model["lecture"]["space_id"])
    entity.save
  end

  def after_update(model)
    entity = Entity.find_by(entity_id: model["lecture"]["id"])
    entity = fill_params(entity, model)
    entity.save
  end

  protected

  def fill_params(entity, model)
    entity.name = model["lecture"]["name"]
    entity.entity_id = model["lecture"]["id"]
    entity.kind = model["lecture"]["lectureable_type"]
    entity.api_url = "esperando_teste"
    entity.core_url = "esperando_teste"
    entity
  end

  def space_wall(space_id)
    wall = Wall.find_by(resource_id: "core:space_#{space_id}")
    return Wall.create(resource_id: "core:space_#{space_id}") if wall.nil?
    wall
  end
end
