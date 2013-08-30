require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }

  it 'has associated people' do
    expect(user.people).to be_instance_of(Array)
  end
end
