require 'json'

class Wally < Grape::API
  format :json

  # GET /walls (get a list of Walls)
  # GET /walls/:id (get a Wall)
  # GET /walls/?resource_id=:resource_id (get all Walls of a resource)
  # POST /walls (create a new Wall)
  # DELETE /walls/:id (delete a Wall)
  get "/" do
    {:teste => "Teste", :segundo => "Outro"}
  end

end

