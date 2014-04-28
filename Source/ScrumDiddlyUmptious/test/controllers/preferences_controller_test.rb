require 'test_helper'

class PreferencesControllerTest < ActionController::TestCase
  setup do
    @preference = preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preference" do
    assert_difference('Preference.count') do
      post :create, preference: { foodsToFilter: @preference.foodsToFilter, isAllergicDairy: @preference.isAllergicDairy, isAllergicEggs: @preference.isAllergicEggs, isAllergicFish: @preference.isAllergicFish, isAllergicGluten: @preference.isAllergicGluten, isAllergicPeanuts: @preference.isAllergicPeanuts, isAllergicShellfish: @preference.isAllergicShellfish, isAllergicSoy: @preference.isAllergicSoy, isAllergicTreenuts: @preference.isAllergicTreenuts, isAllergicWheat: @preference.isAllergicWheat, isAsianVegetarian: @preference.isAsianVegetarian, isDiabetic: @preference.isDiabetic, isHindu: @preference.isHindu, isJain: @preference.isJain, isKosher: @preference.isKosher, isMuslim: @preference.isMuslim, isPescatarian: @preference.isPescatarian, isVegan: @preference.isVegan, isVegetarian: @preference.isVegetarian, user_id: @preference.user_id }
    end

    assert_redirected_to preference_path(assigns(:preference))
  end

  test "should show preference" do
    get :show, id: @preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preference
    assert_response :success
  end

  test "should update preference" do
    patch :update, id: @preference, preference: { foodsToFilter: @preference.foodsToFilter, isAllergicDairy: @preference.isAllergicDairy, isAllergicEggs: @preference.isAllergicEggs, isAllergicFish: @preference.isAllergicFish, isAllergicGluten: @preference.isAllergicGluten, isAllergicPeanuts: @preference.isAllergicPeanuts, isAllergicShellfish: @preference.isAllergicShellfish, isAllergicSoy: @preference.isAllergicSoy, isAllergicTreenuts: @preference.isAllergicTreenuts, isAllergicWheat: @preference.isAllergicWheat, isAsianVegetarian: @preference.isAsianVegetarian, isDiabetic: @preference.isDiabetic, isHindu: @preference.isHindu, isJain: @preference.isJain, isKosher: @preference.isKosher, isMuslim: @preference.isMuslim, isPescatarian: @preference.isPescatarian, isVegan: @preference.isVegan, isVegetarian: @preference.isVegetarian, user_id: @preference.user_id }
    assert_redirected_to preference_path(assigns(:preference))
  end

  test "should destroy preference" do
    assert_difference('Preference.count', -1) do
      delete :destroy, id: @preference
    end

    assert_redirected_to preferences_path
  end
end
