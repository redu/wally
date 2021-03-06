# -*- encoding : utf-8 -*-
require 'erubis'

class Wally < Grape::API
  content_type :html, 'text/html; charset=UTF-8'
  format :html

  helpers do
    def render(template_path, params)
        input = File.read("#{WallyConfig.config.root}/app/#{template_path}")
        eruby = Erubis::Eruby.new(input)
        page = eruby.result(params)
    end
  end

  get ':resource_id' do
    erb_params = {
      resource_id: params[:resource_id],
      user: params[:user].to_json,
      target: params[:target].to_json,
      contexts: params[:contexts].to_json,
      config: params[:config] ? params[:config].to_json : {}
    }

    render 'views/index.erb', erb_params
  end
end


