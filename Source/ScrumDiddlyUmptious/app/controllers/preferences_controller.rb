class PreferencesController < ApplicationController
  before_filter :get_user

  # GET /preferences
  # GET /preferences.json
  def index
    @preferences = user.preferences

    respond_to do |format|
      format.html
      format.xml {render :xml => @preferences}
      format.json {render :json => @preferences}
    end
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
    @preferences = user.preferences.find(params[:id])

    respond_to do |format|
      format.html
      format.xml {render :xml => @preferences}
      format.json {render :json => @preferences}
    end
  end

  # GET /preferences/new
  def new
    @preference = user.preferences.build

    respond_to do |format|
      format.html
      format.xml {render :xml => @preference}
      format.json {render :json => @preference}
    end
  end

  # GET /preferences/1/edit
  def edit
    @preference = user.preferences.find(params[:id])
  end

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = user.preferences.create(preference_params)

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
    @preferences = user.preferences.find(params[:id])

    respond_to do |format|
      if @preference.update(preference_params)
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
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
    @preferences = user.preferences.find(params[:id])
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_user
      user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:isPescatarian, :isVegetarian, :isVegan, :isDiabetic, :isAllergicGluten, :isAllergicPeanuts, :isAllergicTreenuts, :isAllergicDairy, :isAllergicEggs, :isAllergicWheat, :isAllergicSoy, :isAllergicFish, :isAllergicShellfish, :isAsianVegetarian, :isHindu, :isMuslim, :isJain, :isKosher, :foodsToFilter, :user_id)
    end
end
