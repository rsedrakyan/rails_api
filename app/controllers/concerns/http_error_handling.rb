module HttpErrorHandling
  def not_found(e)
    render_error_response([I18n.t('exception.not_found')], 404)
  end

  def render_error_response(errors = [], status)
    render json: { errors: errors }, status: status
  end
end
