# This handles the production installation case where rubocop is not available
# rubocop:disable Lint/HandleExceptions
begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
rescue LoadError
end
# rubocop:enable Lint/HandleExceptions
