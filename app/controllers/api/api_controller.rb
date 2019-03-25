class Api::ApiController < ActionController::API
  include APICommonResponses

  respond_to :json

  protected

  def serialize_resource(resource, serializer)
    response = {}
    response[resource.model_name.param_key.to_sym] = JSON.parse(serializer.new(resource, {}).to_json)
    response
  end

  def serialize_resource_list(resources, serializer)
    response = JSON.parse(ActiveModelSerializers::SerializableResource.new(resources, each_serializer: serializer).to_json)
    response
  end

  def serialize_fixed_values(values)
    values
  end
end
