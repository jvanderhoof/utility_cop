require 'rails_helper'

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

RSpec.describe AppEnvironmentResourcesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # AppEnvironmentResource. As you add validations to AppEnvironmentResource, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AppEnvironmentResourcesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all app_environment_resources as @app_environment_resources" do
      app_environment_resource = AppEnvironmentResource.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:app_environment_resources)).to eq([app_environment_resource])
    end
  end

  describe "GET #show" do
    it "assigns the requested app_environment_resource as @app_environment_resource" do
      app_environment_resource = AppEnvironmentResource.create! valid_attributes
      get :show, {:id => app_environment_resource.to_param}, valid_session
      expect(assigns(:app_environment_resource)).to eq(app_environment_resource)
    end
  end

  describe "GET #edit" do
    it "assigns the requested app_environment_resource as @app_environment_resource" do
      app_environment_resource = AppEnvironmentResource.create! valid_attributes
      get :edit, {:id => app_environment_resource.to_param}, valid_session
      expect(assigns(:app_environment_resource)).to eq(app_environment_resource)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new AppEnvironmentResource" do
        expect {
          post :create, {:app_environment_resource => valid_attributes}, valid_session
        }.to change(AppEnvironmentResource, :count).by(1)
      end

      it "assigns a newly created app_environment_resource as @app_environment_resource" do
        post :create, {:app_environment_resource => valid_attributes}, valid_session
        expect(assigns(:app_environment_resource)).to be_a(AppEnvironmentResource)
        expect(assigns(:app_environment_resource)).to be_persisted
      end

      it "redirects to the created app_environment_resource" do
        post :create, {:app_environment_resource => valid_attributes}, valid_session
        expect(response).to redirect_to(AppEnvironmentResource.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved app_environment_resource as @app_environment_resource" do
        post :create, {:app_environment_resource => invalid_attributes}, valid_session
        expect(assigns(:app_environment_resource)).to be_a_new(AppEnvironmentResource)
      end

      it "re-renders the 'new' template" do
        post :create, {:app_environment_resource => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested app_environment_resource" do
        app_environment_resource = AppEnvironmentResource.create! valid_attributes
        put :update, {:id => app_environment_resource.to_param, :app_environment_resource => new_attributes}, valid_session
        app_environment_resource.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested app_environment_resource as @app_environment_resource" do
        app_environment_resource = AppEnvironmentResource.create! valid_attributes
        put :update, {:id => app_environment_resource.to_param, :app_environment_resource => valid_attributes}, valid_session
        expect(assigns(:app_environment_resource)).to eq(app_environment_resource)
      end

      it "redirects to the app_environment_resource" do
        app_environment_resource = AppEnvironmentResource.create! valid_attributes
        put :update, {:id => app_environment_resource.to_param, :app_environment_resource => valid_attributes}, valid_session
        expect(response).to redirect_to(app_environment_resource)
      end
    end

    context "with invalid params" do
      it "assigns the app_environment_resource as @app_environment_resource" do
        app_environment_resource = AppEnvironmentResource.create! valid_attributes
        put :update, {:id => app_environment_resource.to_param, :app_environment_resource => invalid_attributes}, valid_session
        expect(assigns(:app_environment_resource)).to eq(app_environment_resource)
      end

      it "re-renders the 'edit' template" do
        app_environment_resource = AppEnvironmentResource.create! valid_attributes
        put :update, {:id => app_environment_resource.to_param, :app_environment_resource => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested app_environment_resource" do
      app_environment_resource = AppEnvironmentResource.create! valid_attributes
      expect {
        delete :destroy, {:id => app_environment_resource.to_param}, valid_session
      }.to change(AppEnvironmentResource, :count).by(-1)
    end

    it "redirects to the app_environment_resources list" do
      app_environment_resource = AppEnvironmentResource.create! valid_attributes
      delete :destroy, {:id => app_environment_resource.to_param}, valid_session
      expect(response).to redirect_to(app_environment_resources_url)
    end
  end

end
