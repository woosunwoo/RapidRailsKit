# spec/requests/projects_spec.rb
require "rails_helper"

RSpec.describe "Projects API", type: :request do
  let(:user) { create(:user, password: "password123") }
  let(:headers) { { "Authorization" => "Bearer #{token}" } }
  let(:login_payload) { { user: { email: user.email, password: "password123" } } }

  let(:token) do
    post "/login", params: login_payload.to_json, headers: {
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
    expect(response).to have_http_status(:ok)
    response.headers["Authorization"]&.split(" ")&.last || raise("No token returned")
  end

  describe "GET /projects/:id" do
    context "when accessing own project" do
      let(:project) { create(:project, user: user) }

      it "returns the project" do
        get "/projects/#{project.id}", headers: headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(project.name)
      end
    end

    context "when accessing another user's project" do
      let(:other_user) { create(:user) }
      let(:other_project) { create(:project, user: other_user) }

      it "returns forbidden" do
        get "/projects/#{other_project.id}", headers: headers
        expect(response).to have_http_status(:forbidden)
        expect(response.body).to include("Not authorized")
      end
    end
  end

  describe "POST /projects" do
    it "creates a new project" do
      post "/projects", params: { project: { name: "New Project", description: "A test" } }, headers: headers
      expect(response).to have_http_status(:created)
      expect(response.body).to include("New Project")
    end
  
    it "returns an error with invalid data" do
      post "/projects", params: { project: { name: "" } }, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("can't be blank")
    end
  end
  
  describe "PUT /projects/:id" do
    let(:project) { create(:project, user: user) }
  
    it "updates the project" do
      put "/projects/#{project.id}", params: { project: { name: "Updated Name" } }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Updated Name")
    end
  
    it "returns forbidden for another user's project" do
      other_project = create(:project)
      put "/projects/#{other_project.id}", params: { project: { name: "Hack Attempt" } }, headers: headers
      expect(response).to have_http_status(:forbidden)
    end
  end
  
  describe "DELETE /projects/:id" do
    let!(:project) { create(:project, user: user) }
  
    it "deletes the project" do
      delete "/projects/#{project.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Project.exists?(project.id)).to be_falsey
    end
  
    it "returns forbidden for another user's project" do
      other_project = create(:project)
      delete "/projects/#{other_project.id}", headers: headers
      expect(response).to have_http_status(:forbidden)
    end
  end
  
end
