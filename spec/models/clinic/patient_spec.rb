require 'spec_helper'

describe Clinic::Patient do
  subject {build :clinic_patient}
  it {should validate_presence_of(:practitioner)}
end
