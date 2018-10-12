require 'spec_helper'

#THIS is the file we're supposed to modify...

describe Admin::CategoriesController do
  render_views

  before(:each) do
    Factory(:blog)
    #TODO Delete after removing fixtures
    Profile.delete_all
    henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
    request.session = { :user => henri.id }
  end

  it "test_index" do
    get :index
    assert_response :redirect, :action => 'index'
  end
  
  describe "test_create" do
    
    it 'should create the category' do
      #attrs = attributes_for Factory(:category)
      #post "/admin/categories", attrs
      #assert_not_nil Category.find(@attrs[:id]) 
      dummyCategAttribs = Factory.attributes_for(:category) 
      #Creates attributes w/o creating entry in database
      print(dummyCategAttribs.to_s)
      post :new, category: dummyCategAttribs
      assert_not_nil Category.where(name: dummyCategAttribs[:name])
    end
    
  end
  

  describe "test_edit" do
    before(:each) do
      @cat = Factory(:category)
      get :edit, :id => @cat.id
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have valid category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).valid?
      assigns(:categories).should_not be_nil
    end
    
    it 'should save changes' do
      modifiedAttribs = @cat.attributes
      oldName = modifiedAttribs[:name]
      modifiedAttribs[:name] = "new Testname"
      post :edit, modifiedAttribs
      assert_not_nil Category.where(name: modifiedAttribs[:name])
      assert(Category.where(name: oldName) == [])
    end
    
  end

  it "test_update" do
    post :edit, :id => Factory(:category).id
    assert_response :redirect, :action => 'index'
  end

  describe "test_destroy with GET" do
    before(:each) do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id
    end

    it 'should render destroy template' do
      assert_response :success
      assert_template 'destroy'      
    end
  end

  it "test_destroy with POST" do
    test_id = Factory(:category).id
    assert_not_nil Category.find(test_id)
    get :destroy, :id => test_id

    post :destroy, :id => test_id
    assert_response :redirect, :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
  end
  
end
