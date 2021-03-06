class API::EventsController < ApplicationController
  allow_cors :create
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create

    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if registered_application
      # @event = Event.new(event_params)
      name = params[:event][:name]
      payload = params[:event][:payload]
      @event = registered_application.events.new(name: name, payload: payload)

      if @event.save
        render json: @event, status: :created
      else
        render @event.errors, status: :unprocessable_entity
      end
    else
      render json: "Unregistered application", status: :unprocessable_entity
    end
  end

  private

  def event_params
    # params.require(:event).permit(:name).tap do |whitelisted|
    #   whitelisted[:payload] = params[:event][:name]
    # end

    params.require(:event).permit(:name, payload: params[:product][:payload].try(:keys))
  end
end