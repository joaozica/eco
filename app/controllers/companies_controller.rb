#encoding: utf-8
class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.order("legal_name").all

    respond_to do |format|
      if current_user.admin?
        format.html # index.html.erb
        format.json { render json: @companies }
      else
        format.html {render "public/403.html"}
      end
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      if current_user.admin?
          format.html # index.html.erb
          format.json { render json: @companies }
      else
          format.html {render "public/403.html"}
      end
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new
    respond_to do |format|
    if current_user.admin?
        format.html # index.html.erb
        format.json { render json: @companies }
    else
        format.html {render "public/403.html"}
      end
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    if not current_user.admin?
      render "public/403.html"
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    
    @company = Company.new(params[:company])
    
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Empresa foi criada com sucesso.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Empresa foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  
  
  def donors
    @company = Company.find_by_id (params[:id])
    @donors = Donor.order("name").where("company_id = ?", @company.id)

    options = ""
    @donors.each do |donor|
      options += "<option value=\"#{donor.id}\" > #{donor.name}</option>"
    end
    render text: options
  end
  
  def users
    @company = Company.find_by_id (params[:id])
    @users = User.order("name").where("company_id = ?", @company.id)

    options = ""
    @users.each do |user|
      options += "<option value=\"#{user.name}\" > #{user.name}</option>"
    end
    render text: options
  end


  def user_company_index
    @company = Company.find_by_id(current_user.company_id)
  end

  def user_company
    @company = Company.find_by_id(current_user.company_id)
  end

  def set_avatar
    @current_user  = Company.find(params[:id])
    @avatar_errors = Array.new

    respond_to do |format|
      format.html { 
        if not params[:avatar].blank?
          @avatar = params[:avatar].first
          if FastImage.size(@avatar.tempfile) == [198, 71] then
            if @avatar.content_type == "image/jpeg" || @avatar.content_type == "image/png"

              if @avatar.content_type == "image/jpeg"
                @format = "jpg"
                if File.exist?("./public/uploads/images/companies/#{@current_user.id}.png")
                  FileUtils.rm("./public/uploads/images/companies/#{@current_user.id}.png")
                end
              elsif @avatar.content_type == "image/png"
                @format = "png"
                if File.exist?("./public/uploads/images/companies/#{@current_user.id}.jpg")
                  FileUtils.rm("./public/uploads/images/companies/#{@current_user.id}.jpg")
                end
              end

              @avatar_file = "./public/uploads/images/companies/#{@current_user.id}.#{@format}"
                
              FileUtils.cp(@avatar.tempfile, @avatar_file)
              if File.exist?(@avatar.tempfile)
                redirect_to @current_user
              else
                @avatar_errors.push("Não foi possível fazer o upload da sua imagem. Tente novamente mais tarde.")
               redirect_to @current_user, notice: @avatar_errors
              end
            else
              @avatar_errors.push("O formato da imagem é inválido. A imagem deve estar no formato JPEG ('*.jpg') ou PNG ('*.png').")
              redirect_to @current_user, notice: @avatar_errors
            end
          else
            @avatar_errors.push("O tamanho da imagem deve ser de exatamente 198 por 71 pixels (198x71px).")
            redirect_to @current_user, notice: @avatar_errors
          end
        else
          @avatar_errors.push("Selecione uma imagem do seu computador.")
          redirect_to @current_user, notice: @avatar_errors
        end
      }
    end
  end

  def user_set_avatar
    @current_user = current_user

    @avatar_errors = Array.new

    respond_to do |format|
      format.html { 
        if not params[:avatar].blank?
          @avatar = params[:avatar].first
          if FastImage.size(@avatar.tempfile) == [198, 71] then
            if @avatar.content_type == "image/jpeg" || @avatar.content_type == "image/png"

              if @avatar.content_type == "image/jpeg"
                @format = "jpg"
                if File.exist?("./public/uploads/images/companies/#{@current_user.company.id}.png")
                  FileUtils.rm("./public/uploads/images/companies/#{@current_user.company.id}.png")
                end
              elsif @avatar.content_type == "image/png"
                @format = "png"
                if File.exist?("./public/uploads/images/companies/#{@current_user.company.id}.jpg")
                  FileUtils.rm("./public/uploads/images/companies/#{@current_user.company.id}.jpg")
                end
              end

              @avatar_file = "./public/uploads/images/companies/#{@current_user.company.id}.#{@format}"
                
              FileUtils.cp(@avatar.tempfile, @avatar_file)
              if File.exist?(@avatar.tempfile)
                redirect_to '/user_company_index'
              else
                @avatar_errors.push("Não foi possível fazer o upload da sua imagem. Tente novamente mais tarde.")
                redirect_to '/user_company', notice: @avatar_errors
              end
            else
              @avatar_errors.push("O formato da imagem é inválido. A imagem deve estar no formato JPEG ('*.jpg') ou PNG ('*.png').")
              redirect_to'/user_company', notice: @avatar_errors
            end
          else
            @avatar_errors.push("O tamanho da imagem deve ser de exatamente 198 por 71 pixels (198x71px).")
            redirect_to '/user_company', notice: @avatar_errors
          end
        else
          @avatar_errors.push("Selecione uma imagem do seu computador.")
          redirect_to '/user_company', notice: @avatar_errors
        end
      }
    end
  end

end
