module APICommonResponses
  extend ActiveSupport::Concern

  def render_success
    render json: { status: 200 }, status: :ok
  end

  def render_created
    render json: { status: 201 }, status: :created
  end

  def render_unprocessable_entity_error(resource = nil)
    data = verify_errors(resource)
    render json: data, status: :unprocessable_entity
  end

  def render_not_found_error
    render json: { status: 404 }, status: :not_found
  end

  def render_unauthorized_error
    render json: { status: 401 }, status: :unauthorized
  end

  private

  def verify_errors(resource)
    return { errors: resource }
  end
end
