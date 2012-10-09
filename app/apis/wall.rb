require "debugger"

class Wally < Grape::API
  format :json

  helpers do
    def current_user
      @current_user ||= Author.find_by(token: params[:token])
    end

    def authorize!(action)
      error!("401 Unauthorized", 401) unless current_user and permit.able_to?(:read, action)
    end

    def permit
      @permit ||= Permit::Mechanism.new(:subject_id => current_user.subject_permit, :service_name => "wally")
    end
  end

  resource :walls do
    params do
       requires :token, type: String, desc: "Your api token."
    end
    get ':resource_id' do
      authorize!(params[:resource_id])
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
