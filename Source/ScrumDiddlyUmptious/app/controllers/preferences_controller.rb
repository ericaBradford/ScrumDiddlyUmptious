class PreferencesController < ApplicationController
  before_action :get_user
  before_action :fixed_params, only: [:update, :create]
  add_breadcrumb "Home", :recipes_path

  # GET /preferences
  # GET /preferences.json
  def index
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
    @preference = Preference.find_by_id_Users(@user.id)

    respond_to do |format|
      format.html
      format.xml {render :xml => @preferences}
      format.json {render :json => @preferences}
    end
    add_breadcrumb @user.username, user_path(@user)
  end

  # GET /preferences/new
  def new
    @preference = @user.preferences.build

    respond_to do |format|
      format.html
      format.xml {render :xml => @preference}
      format.json {render :json => @preference}
    end
  end

  # GET /preferences/1/edit
  def edit
    @preferences = Preference.find_by_id_Users(@user.id)
    @theUser = User.find(@user.id)
    add_breadcrumb @theUser.username, user_path(@theUser)
    add_breadcrumb :edit, edit_user_preference_path(@user, @preferences.id)
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = @user.preferences.create(preference_params)

    respond_to do |format|
      if @preference.save
        format.html { redirect_to recipes_path }
        format.xml {render :xml => @preference, :status => :created, :location => [@preference.user, @preference]}
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    @preferences = Preference.find_by_id_Users(@user.id)

    respond_to do |format|
      if @preferences.update(fixed_params)
        format.html { redirect_to user_preference_path(current_user.id, :id), notice: 'Preferences were successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  def destroy
    @preferences = @user.preferences.find(params[:id])
    @preferences.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_user
      @user = User.find(params[:user_id])
    end

    def fixed_params
      id_Users = params[:user_id]
       params.require(:preference).permit(:isPescatarian, :isVegetarian, :isVegan, :isDiabetic, :isAllergicGluten, :isAllergicPeanuts, :isAllergicTreenuts, :isAllergicDairy, :isAllergicEggs, :isAllergicWheat, :isAllergicSoy, :isAllergicFish, :isAllergicShellfish, :isAsianVegetarian, :isHindu, :isMuslim, :isJain, :isKosher, :foodsToFilter, :id_Users)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:isPescatarian, :isVegetarian, :isVegan, :isDiabetic, :isAllergicGluten, :isAllergicPeanuts, :isAllergicTreenuts, :isAllergicDairy, :isAllergicEggs, :isAllergicWheat, :isAllergicSoy, :isAllergicFish, :isAllergicShellfish, :isAsianVegetarian, :isHindu, :isMuslim, :isJain, :isKosher, :foodsToFilter, :user_id)
    end
end
