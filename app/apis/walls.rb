# -*- encoding : utf-8 -*-
class Wally < Grape::API
  format :json

  helpers do
    def extract_token
      if env['HTTP_AUTHORIZATION']
        env['HTTP_AUTHORIZATION'].slice!("OAuth ")
        env['HTTP_AUTHORIZATION']
      else
        error!("Missing parameter Authorization in header.", 401)
      end
    end

    def current_user
      @current_user ||= Author.find_by(token: extract_token)
    end

    def authorize!(resource)
      error!("401 Unauthorized - You don't have access to this resource or your token doesn't exist", 401) unless current_user and current_ability.can?(:read, resource)
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end
  end

  resource :walls do

    get ':resource_id' do
      authorize!(params[:resource_id])
      wall = Wall.find_by(resource_id: params[:resource_id])
      if wall
        wall.define_rule(current_ability, current_user)
        wall.extend(WallRepresenter)
        wall.to_json
      else
        status 404
        ""
      end
    end
  end

end

