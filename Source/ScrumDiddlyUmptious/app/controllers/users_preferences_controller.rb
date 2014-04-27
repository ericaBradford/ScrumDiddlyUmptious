class UsersPreferencesController < ApplicationController

  def create
    #:id_Users just needs to be replaced with however I'll get the id that registrations_controller passes in
    @users_preferences = Users_Preferences.new(:id_Users, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "")
    @users_preferences.save
  end

  def show
    
  end

  def edit
    @users_preferences = Users_Preferences.find_by id_Users: user_id.to_f
    authorize! :update, @users_preferences
  end

  def update
  end

  def destroy
  end

 private
  def users_preferences_params
    params.require(:users_preferences).permit(:id_Users, :foodToFilter, :isVegan, :isVegetarian, :isPescatarian, :isDiabetic, :isAllergicGluten, 
:isAllergicPeanuts, :isAllergicTreenuts, :isAllergicDairy, :isAllergicEggs, :isAllergicWheat, 
:isAllergicSoy, :isAllergicFish, :isAllergicshellfish, :isAsianVegetarian, :isHindu, :isMuslim, :isJain)
  end

end
