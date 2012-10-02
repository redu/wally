class Wally < Grape::API
  format :json

  resource :walls do
    get ':resource_id' do
      wall = Wall.find_by(resource_id: params[:resource_id])
      if wall
        wall.extend(WallRepresenter)
        wall.to_json
      else
        status 404
        ""
      end
    end
  end
end

