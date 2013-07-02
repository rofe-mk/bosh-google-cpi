require 'spec_helper'
require_relative '../../lib/helpers/data_dog_reporter'

module Bosh
  module Helpers
    describe DataDogReporter do
      subject(:sender) { described_class.new(data_dog_client) }
      let(:data_dog_client) { double(Dogapi::Client) }
      let(:example) do
        double(RSpec::Core::Example, metadata:
          {
            description: 'foo bar baz',
            execution_result: {run_time: 3.14}
          })
      end

      it 'should send a message to DataDog when an example passes' do
        data_dog_client.should_receive(:emit_point).with('bosh.ci.bat.test_example_duration3', 3.14, tags: %w[infrastructure:test example:foo-bar-baz])
        sender.report_on(example)
      end
    end
  end
end