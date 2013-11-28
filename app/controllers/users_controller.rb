# encoding: UTF-8
class UsersController < ApplicationController
  include UsersHelper
  before_filter :checked_user,:except => [:show,:edit,:update,:index_user]
	def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  	end
   def create
    @user = User.new(params[:user])
    

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/users/#{@user.id}", notice: 'Usuário foi criado com sucesso.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

	def index
		@users = User.order(:name)

    	respond_to do |format|
      		format.html # index.html.erb
      		format.json { render json: @users }
    	end
	end
	def delete
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to  "/users" }
      format.json { head :no_content }
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
       respond_to do |format|
      if @user.update_attributes(params[:user])
        current_user = @user
        format.html { redirect_to "/users/#{@user.id}", notice: 'Usuário foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def index_user
    @users = User.find(current_user.id)

      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @users }
      end
  end

    
      
end








