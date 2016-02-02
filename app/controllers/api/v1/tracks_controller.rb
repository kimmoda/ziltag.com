class Api::V1::TracksController < ApiController
  def record
    if params[:event].blank?
      render json: {error: 'event is blank'}
    else
      _track = track(params[:event])
      if _track.errors.blank?
        render json: {}
      else
        render json: {error: _track.full_messages.first}
      end
    end
  end
end
