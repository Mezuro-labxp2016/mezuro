require 'spec_helper'

describe KolektiMetricfu::Parsers::Base do
  it 'is expected to be a Kolekti Parser' do
    expect(subject).to be_a(Kolekti::Parser)
  end

  describe 'class methods' do
    describe 'module_name_suffix' do
      cases = {
        'module#none' => '',
        'self.method' => '.method',
        'Class#method' => '.Class.method',
        'Module::Class#self.method' => '.Module.Class.method'
      }

      cases.each do |input, output|
        it "is expected to return '#{output}' when called with '#{input}'" do
          expect(described_class.module_name_suffix(input)).to eq(output)
        end
      end
    end
  end
end
