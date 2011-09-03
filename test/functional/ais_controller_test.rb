require 'test_helper'

class AisControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "index renders index when user is signed in" do
    sign_in users(:bob)
    get :index
    assert_template :index
    assert_response :success
  end

  test "index redirects to public when user is not signed in" do
    get :index
    assert_redirected_to :action => "public"
  end

  test "show allows ai owner to view it" do
    sign_in users(:bob)
    get :show, :id => ais(:tigh)
    assert_response :success
  end

  test "show allows non owner to view public ai" do
    sign_in users(:bob)
    get :show, :id => ais(:chief)
    assert_response :success
  end

  test "show allows anonymous user to view public ai" do
    get :show, :id => ais(:chief)
    assert_response :success
  end

  test "show redirects to index when non owner tries to view private ai" do
    sign_in users(:rex)
    get :show, :id => ais(:tigh)
    assert_redirected_to ais_path
  end

  test "show redirects to public when anonymous user tries to view private ai" do
    get :show, :id => ais(:tigh)
    assert_redirected_to public_ais_path
  end

  test "new allows acces to signed in user" do
    sign_in users(:bob)
    get :new
    assert_template :new
  end

  test "new redirects anonymous user to sign in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "create valid ai redirects to new record" do
    Ai.any_instance.stubs(:valid?).returns(true)
    sign_in users(:bob)
    
    # todo: this fails if ai is not given, should probably fix that
    post :create , :ai => {}
    assert_redirected_to ai_url(assigns(:ai))
  end

  test "create invalid ai rerenders the form" do
    Ai.any_instance.stubs(:valid?).returns(false)
    sign_in users(:bob)
    post :create , :ai => {}
    assert_template :new
  end

  test "edit allows access to owner" do
    sign_in users(:bob)
    get :edit, :id => ais(:tigh)
    assert_template :edit
  end

  test "edit redirects non owner to index" do
    sign_in users(:bob)
    get :edit, :id => ais(:chief)
    assert_redirected_to ais_path
  end

  test "edit redirects anonymous user to sign in" do
    get :edit, :id => ais(:chief)
    assert_redirected_to new_user_session_path
  end

  test "update valid ai redirects to record" do
    Ai.any_instance.stubs(:valid?).returns(true)
    sign_in users(:bob)
    put :update , :id => ais(:tigh), :ai => {}
    assert_redirected_to ai_url(assigns(:ai))
  end

  test "update invalid ai rerenders the form" do
    Ai.any_instance.stubs(:valid?).returns(false)
    sign_in users(:bob)
    put :update , :id => ais(:tigh), :ai => {}
    assert_template :edit
  end

  test "destroy delete the record" do
    ai = ais(:tigh)
    sign_in users(:bob)
    delete :destroy, :id => ai
    assert_redirected_to ais_path
    assert !Ai.exists?(ai.id)
  end

  test "download allows non owner to download public ai" do
    # todo: figure out how to properly test send_data
    sign_in users(:bob)
    get :download, :id => ais(:chief)
    assert_response :success
  end

  test "download allos anonymous user to download public ai" do
    get :download, :id => ais(:chief)
    assert_response :success
  end

  test "download redirects non owner of private ai to index" do
    sign_in users(:rex)
    get :download, :id => ais(:tigh)
    assert_redirected_to ais_path
  end

  test "download redirects anonymous user to public ais path for private ai" do
    get :download, :id => ais(:tigh)
    assert_redirected_to public_ais_path
  end
end
