class HealthController < ApplicationController
  def health
    puts status
    render json: {api: 'OK'}, status: :ok
  end
end
