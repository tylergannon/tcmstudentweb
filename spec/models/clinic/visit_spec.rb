require 'spec_helper'

describe Clinic::Visit do
  subject {build :clinic_visit}
  it {should validate_presence_of(:practitioner)}
  it {should validate_presence_of(:patient)}
  it {should validate_presence_of(:appointment_time)}
end
