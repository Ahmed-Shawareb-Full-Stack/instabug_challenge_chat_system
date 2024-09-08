class AppsController < ApplicationController
  before_action :set_app, only: [ :show, :update ]

  def index
    @apps = App.all
    json_response(@apps.as_json(except: [ :id ]))
  end

  def show
    json_response(@app.as_json(except: [ :id ]))
  end

  def create
    @app = App.create!(app_params)
    json_response({ token: @app.token }, :created)
  end

  def update
    @app.update!(app_params)
    json_response({ message: "App (#{params[:token]}) updated successfully." })
  end

  private

  def set_app
    @app = App.find_by!(token: params[:token])
  end

  def app_params
    params.permit(:name)
  end
end
