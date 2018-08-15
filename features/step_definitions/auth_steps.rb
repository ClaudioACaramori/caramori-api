Given("um usuario da aplicacao") do
  @user = FactoryBot.create(:user)
end

When("ele fornece as credencias validas") do
  @auth = {password: "secret123", email: "diogo@jera.com.br"}
end

Then("ele deve estar autorizado a acessar a aplicacao") do
  auth_response = Users::SessionService.call(session_params: @auth)
  expect(auth_response.success?).to be true
end

When("ele fornece as credencias invalidas") do
  @invalid_auth = {password: "piroca", email: "diogo@jera.com.br"}
end

Then("ele nao deve estar autorizado a acessar a aplicacao") do
  auth_response = Users::SessionService.call(session_params: @invalid_auth)
  expect(auth_response.success?).to be false
end