require 'test_helper'

class AisControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Ai.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Ai.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Ai.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ai_url(assigns(:ai))
  end

  def test_edit
    get :edit, :id => Ai.first
    assert_template 'edit'
  end

  def test_update_invalid
    Ai.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Ai.first
    assert_template 'edit'
  end

  def test_update_valid
    Ai.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Ai.first
    assert_redirected_to ai_url(assigns(:ai))
  end

  def test_destroy
    ai = Ai.first
    delete :destroy, :id => ai
    assert_redirected_to ais_url
    assert !Ai.exists?(ai.id)
  end
end
