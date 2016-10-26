require 'spec_helper'

describe Kolekti::Parser do
  describe 'methods' do
    describe 'parse' do
      it 'is expected to raise a NotImplementedError' do
        expect { described_class.parse(nil, nil, nil) }.to raise_error(NotImplementedError)
      end
    end

    describe 'default_value' do
      it 'is expected to raise a NotImplementedError' do
        expect { described_class.default_value }.to raise_error(NotImplementedError)
      end
    end

    describe 'parse_file_name' do
      cases = {
       'out' => 'out',
       'out/' => 'out',
       'out.txt' => 'out',
       'out_1.txt' => 'out_1',
       'in.out.1.txt' => 'in_out_1',
       '/out/in.1.txt' => 'out.in_1',
       '/out.2/in_1' => 'out_2.in_1',
       'out.3/out.2/in_1' => 'out_3.out_2.in_1'
      }

      cases.each do |input, output|
        it "is expected to receive '#{input}' and to respond with '#{output}'" do
          expect(described_class.parse_file_name(input)).to eq(output)
        end
      end
    end
  end
end
