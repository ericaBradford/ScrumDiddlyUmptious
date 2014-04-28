require 'test_helper'

class UsersPreferencesControllerTest < ActionController::TestCase
  setup do
    @users_preference = users_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_preference" do
    assert_difference('UsersPreference.count') do
      post :create, users_preference: { foodsToFilter: @users_preference.foodsToFilter, isAllergicDairy: @users_preference.isAllergicDairy, isAllergicEggs: @users_preference.isAllergicEggs, isAllergicFish: @users_preference.isAllergicFish, isAllergicGluten: @users_preference.isAllergicGluten, isAllergicPeanuts: @users_preference.isAllergicPeanuts, isAllergicShellfish: @users_preference.isAllergicShellfish, isAllergicSoy: @users_preference.isAllergicSoy, isAllergicTreenuts: @users_preference.isAllergicTreenuts, isAllergicWheat: @users_preference.isAllergicWheat, isAsianVegetarian: @users_preference.isAsianVegetarian, isDiabetic: @users_preference.isDiabetic, isHindu: @users_preference.isHindu, isJain: @users_preference.isJain, isKosher: @users_preference.isKosher, isMuslim: @users_preference.isMuslim, isPescatarian: @users_preference.isPescatarian, isVegan: @users_preference.isVegan, isVegetarian: @users_preference.isVegetarian, user_id: @users_preference.user_id }
    end

    assert_redirected_to users_preference_path(assigns(:users_preference))
  end

  test "should show users_preference" do
    get :show, id: @users_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_preference
    assert_response :success
  end

  test "should update users_preference" do
    patch :update, id: @users_preference, users_preference: { foodsToFilter: @users_preference.foodsToFilter, isAllergicDairy: @users_preference.isAllergicDairy, isAllergicEggs: @users_preference.isAllergicEggs, isAllergicFish: @users_preference.isAllergicFish, isAllergicGluten: @users_preference.isAllergicGluten, isAllergicPeanuts: @users_preference.isAllergicPeanuts, isAllergicShellfish: @users_preference.isAllergicShellfish, isAllergicSoy: @users_preference.isAllergicSoy, isAllergicTreenuts: @users_preference.isAllergicTreenuts, isAllergicWheat: @users_preference.isAllergicWheat, isAsianVegetarian: @users_preference.isAsianVegetarian, isDiabetic: @users_preference.isDiabetic, isHindu: @users_preference.isHindu, isJain: @users_preference.isJain, isKosher: @users_preference.isKosher, isMuslim: @users_preference.isMuslim, isPescatarian: @users_preference.isPescatarian, isVegan: @users_preference.isVegan, isVegetarian: @users_preference.isVegetarian, user_id: @users_preference.user_id }
    assert_redirected_to users_preference_path(assigns(:users_preference))
  end

  test "should destroy users_preference" do
    assert_difference('UsersPreference.count', -1) do
      delete :destroy, id: @users_preference
    end

    assert_redirected_to users_preferences_path
  end
end
