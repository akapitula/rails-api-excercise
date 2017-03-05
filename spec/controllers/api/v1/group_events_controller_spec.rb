require 'rails_helper'

RSpec.describe Api::V1::GroupEventsController, type: :controller do
  let(:group_event) { create(:group_event) }

  describe "#index" do
    it "retrieves all" do
      create_list(:group_event, 5)
      get :index, params: {format: :json}

      expect(response.body).to have_json_size(5)
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "returns specific one" do
      get :show, params: {id: group_event, format: :json}
      
      expect(response.body).to have_json_path('published')
      expect(response.body).to have_json_size(9)
      expect(response).to be_success
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "create a new group event" do
        expect {
          post :create, params: {group_event: attributes_for(:group_event), format: :json}
        }.to change(GroupEvent, :count).by(1)

        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      it "fails on create" do
        expect {
          post :create, params: {group_event: { duration: 0 }, format: :json}
        }.to_not change(GroupEvent, :count)

        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates attributes" do
        put :update, params: {id: group_event, group_event: { name: 'group event name' }, format: :json}
        group_event.reload

        expect(group_event.name).to eq('group event name')
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      it "fails on update" do
        put :update, params: {id: group_event, group_event: { name: 'group event name', duration: 1.2 }, format: :json}
        group_event.reload

        expect(group_event.name).to_not eq('group event name')
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "mark as deleted" do
      delete :destroy, params: {id: group_event, format: :json}

      group_event.reload
      expect(group_event.deleted).to be true
      expect(response.status).to eq(204)
    end
  end
end
