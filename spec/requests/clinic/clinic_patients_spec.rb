require 'spec_helper'

describe "Clinic::Patients" do
  describe "GET /clinic_patients" do
    it "works! (now write some real specs)" do
      get clinic_patients_path
      expect(response.status).to be(200)
    end
  end
end
