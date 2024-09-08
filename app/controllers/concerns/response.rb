module Response
  def json_response(data, status = :ok)
    render json: data, status: status
  rescue => e
    render json: { error: "Invalid data format", message: e.message }, status: :unprocessable_entity
  end
end
