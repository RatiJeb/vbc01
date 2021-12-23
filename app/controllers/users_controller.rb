class UsersController < ApplicationController
    layout 'simple'

    before_action :set_default_country, only: %i[ new create ]
    before_action :set_user_and_profile, only: %i[ edit destroy]

    def index
        @users = User.all
    end

    def new
        @user = User.new        
        @profile = @user.build_profile
        #@user.terms_of_use = nil
    end


    def create
        @user = User.new(user_params)
        @profile = @user.build_profile(profile_params)
        if @user.save
            redirect_to users_url
        else
            @cities = City.by_country(@user.country_id)
            render :new
        end
    end

    def edit
        @countries = Country.all
        @cities = City.where(country_id: @user.country_id)
    end

    def update

        @user = User.find(params[:id])
    
        @user.profile.assign_attributes(profile_params)
    
        if @user.update(user_params)
            redirect_to users_url
        else
            @cities = City.by_country(@user.country_id)
            render :edit
        end
    end

    def destroy
        ActiveRecord::Base.transaction do

            @user.profile.destroy!
        
            @user.destroy!


            respond_to do |format|
                format.html { redirect_to users_url, notice: "User was successfully destroyed." }
            end
        end
    end

    private

    def set_default_country
        @countries = Country.all
        @cities = []
    end

    def set_user_and_profile
        @user = User.find(params[:id])
        @profile = @user.profile
    end

    def user_params
        params.require(:user).permit(:email, :username, :pin, :terms_of_use, :country_id, :city_id)
    end

    def profile_params
        params.require(:profile).permit(:first_name, :last_name, :phone_number, :birth_date, :about_me)
    end
end