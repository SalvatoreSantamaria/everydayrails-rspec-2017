# this code now works because I've changed the code from page ~114 in the request_spec_helper, and am using code from the devise wiki 
# https://github.com/heartcombo/devise/wiki/How-To:-sign-in-and-out-a-user-in-Request-type-specs-(specs-tagged-with-type:-:request)

require 'rails_helper'

RSpec.describe "Projects", type: :request do
  context "as an authenticated user" do
    #Refactoring with let
    #before do
      #@user = FactoryBot.create(:user)
    #end
    let(:user) { FactoryBot.create(:user)}
    

    context "with valid attributes" do
      it "adds a project" do
        project_params = FactoryBot.attributes_for(:project)
        sign_in user
        expect {
          post projects_path, params: { project: project_params }
        }.to change(user.projects, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not add a project" do
        project_params = FactoryBot.attributes_for(:project, :invalid)
        sign_in user
        expect {
          post projects_path, params: { project: project_params }
        }.to_not change(user.projects, :count)
      end
    end
  end
end
