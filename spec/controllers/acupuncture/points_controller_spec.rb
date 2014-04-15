require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Acupuncture::PointsController do

  # This should return the minimal set of attributes required to create a valid
  # Acupuncture::Point. As you add validations to Acupuncture::Point, be sure to
  # adjust the attributes here as well.
  let(:channel) {create :acupuncture_channel, name: 'Lung', abbreviation: 'Lu'}
  let(:valid_attributes) { { "channel_id" => channel.id, "position" => 1, pinyin: 'Zhong Fu' } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Acupuncture::PointsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all acupuncture_points as @acupuncture_points" do
      point = Acupuncture::Point.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:acupuncture_points)).to eq([point])
    end
  end

  describe "GET show" do
    it "assigns the requested acupuncture_point as @acupuncture_point" do
      point = Acupuncture::Point.create! valid_attributes
      get :show, {:id => point.to_param}, valid_session
      expect(assigns(:acupuncture_point)).to eq(point)
    end
  end

  describe "GET new" do
    it "assigns a new acupuncture_point as @acupuncture_point" do
      get :new, {}, valid_session
      expect(assigns(:acupuncture_point)).to be_a_new(Acupuncture::Point)
    end
  end

  describe "GET edit" do
    it "assigns the requested acupuncture_point as @acupuncture_point" do
      point = Acupuncture::Point.create! valid_attributes
      get :edit, {:id => point.to_param}, valid_session
      expect(assigns(:acupuncture_point)).to eq(point)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Acupuncture::Point" do
        expect {
          post :create, {:acupuncture_point => valid_attributes}, valid_session
        }.to change(Acupuncture::Point, :count).by(1)
      end

      it "assigns a newly created acupuncture_point as @acupuncture_point" do
        post :create, {:acupuncture_point => valid_attributes}, valid_session
        expect(assigns(:acupuncture_point)).to be_a(Acupuncture::Point)
        expect(assigns(:acupuncture_point)).to be_persisted
      end

      it "redirects to the created acupuncture_point" do
        post :create, {:acupuncture_point => valid_attributes}, valid_session
        expect(response).to redirect_to(Acupuncture::Point.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved acupuncture_point as @acupuncture_point" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Acupuncture::Point).to receive(:save).and_return(false)
        post :create, {:acupuncture_point => { "channel_id" => "invalid value" }}, valid_session
        expect(assigns(:acupuncture_point)).to be_a_new(Acupuncture::Point)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Acupuncture::Point).to receive(:save).and_return(false)
        post :create, {:acupuncture_point => { "channel_id" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested acupuncture_point" do
        point = Acupuncture::Point.create! valid_attributes
        # Assuming there are no other acupuncture_points in the database, this
        # specifies that the Acupuncture::Point created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Acupuncture::Point).to receive(:update).with({ "channel_id" => "" })
        put :update, {:id => point.to_param, :acupuncture_point => { "channel_id" => "" }}, valid_session
      end

      it "assigns the requested acupuncture_point as @acupuncture_point" do
        point = Acupuncture::Point.create! valid_attributes
        put :update, {:id => point.to_param, :acupuncture_point => valid_attributes}, valid_session
        expect(assigns(:acupuncture_point)).to eq(point)
      end

      it "redirects to the acupuncture_point" do
        point = Acupuncture::Point.create! valid_attributes
        put :update, {:id => point.to_param, :acupuncture_point => valid_attributes}, valid_session
        expect(response).to redirect_to(point)
      end
    end

    describe "with invalid params" do
      it "assigns the acupuncture_point as @acupuncture_point" do
        point = Acupuncture::Point.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Acupuncture::Point).to receive(:save).and_return(false)
        put :update, {:id => point.to_param, :acupuncture_point => { "channel_id" => "invalid value" }}, valid_session
        expect(assigns(:acupuncture_point)).to eq(point)
      end

      it "re-renders the 'edit' template" do
        point = Acupuncture::Point.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Acupuncture::Point).to receive(:save).and_return(false)
        put :update, {:id => point.to_param, :acupuncture_point => { "channel_id" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested acupuncture_point" do
      point = Acupuncture::Point.create! valid_attributes
      expect {
        delete :destroy, {:id => point.to_param}, valid_session
      }.to change(Acupuncture::Point, :count).by(-1)
    end

    it "redirects to the acupuncture_points list" do
      point = Acupuncture::Point.create! valid_attributes
      delete :destroy, {:id => point.to_param}, valid_session
      expect(response).to redirect_to(acupuncture_points_url)
    end
  end

end