require 'tmpdir'

Given(/^the "([^"]+)" repository is cloned$/) do |repository_url|
  @repository_path = Dir.mktmpdir

  expect(system("git", "clone", "-q", repository_url, @repository_path, [:out, :err] => '/dev/null')).to be_truthy
  expect(system("chmod", "-R", "a+rX", @repository_path)).to be_truthy
end
