When(/^I ask a module result with the same id of the given module result$/) do
  @found_module_result = KalibroClient::Entities::Processor::ModuleResult.find(@module_result.id)
end

When(/^I ask for an inexistent module result$/) do
  @is_error = false
  begin
    KalibroClient::Entities::Processor::ModuleResult.find(-1)
  rescue Likeno::Errors::RecordNotFound
    @is_error = true
  end
end

When(/^I ask for the children of the processing root module result$/) do
  @children = KalibroClient::Entities::Processor::ModuleResult.
    find(@repository.processing.root_module_result_id).children
end

Then(/^I should get a list with the children module results$/) do
  expect(@children.first).to be_a(KalibroClient::Entities::Processor::ModuleResult)
end

Then(/^I should get the given module result$/) do
  expect(@found_module_result).to eq(@module_result)
end

Given(/^I get the module result of the processing$/) do
  @module_result = KalibroClient::Entities::Processor::ModuleResult.
    find(@repository.processing.root_module_result_id)
end

When(/^I ask for the history of the given module result$/) do
  @history = KalibroClient::Entities::Processor::ModuleResult.history_of(@module_result, @repository.id)
end

Then(/^I should get a list with date module results$/) do
  expect(@history).to be_a(Array)
end

Then(/^I should get a module_result$/) do
  expect(@module_result).to be_a(KalibroClient::Entities::Processor::ModuleResult)
end

Then(/^The first children should have a module$/) do
  expect(@children.first.kalibro_module).to be_a(KalibroClient::Entities::Processor::KalibroModule)
end

When(/^I ask for the kalibro_module of the processing root module result$/) do
  @kalibro_module = KalibroClient::Entities::Processor::ModuleResult.find(@repository.processing.root_module_result_id).kalibro_module
end

Then(/^I should get a KalibroModule$/) do
  expect(@kalibro_module).to be_a(KalibroClient::Entities::Processor::KalibroModule)
end
