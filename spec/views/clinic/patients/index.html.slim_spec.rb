require 'spec_helper'

describe "clinic/patients/index" do
  before(:each) do
    assign(:clinic_patients, Kaminari.paginate_array [
      stub_model(Clinic::Patient,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(Clinic::Patient,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of clinic/patients" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
