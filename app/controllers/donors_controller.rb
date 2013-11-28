# encoding: UTF-8
class DonorsController < ApplicationController
  # GET /donors
  # GET /donors.json

  def index
    @donors = Donor.order("name").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donors }
    end
  end

  def import_data
    
  end

  def import
   @donor_import = params[:file]
   if @donor_import.present?
      Donor.import(@donor_import)
      redirect_to "/import_data", notice: 'Funcionários importados com sucesso.' 
    else
      redirect_to "/import_data", notice: 'Selecione um arquivo' 
    end
      
  end
  

  # GET /donors/1
  # GET /donors/1.json
  def show
    @donor = Donor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donor }
    end
  end

  # GET /donors/new
  # GET /donors/new.json
  def new
    @donor = Donor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donor }
    end
  end

  # GET /donors/1/edit
  def edit
    @donor = Donor.find(params[:id])
  end

  # POST /donors
  # POST /donors.json
  def create
    @donor = Donor.new(params[:donor])
    

    respond_to do |format|
      if @donor.save
        format.html { redirect_to @donor, notice: 'Funcionário foi criado com sucesso.' }
        format.json { render json: @donor, status: :created, location: @donor }
      else
        format.html { render action: "new" }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /donors/1
  # PUT /donors/1.json
  def update
    @donor = Donor.find(params[:id])

    respond_to do |format|
      if @donor.update_attributes(params[:donor])
        format.html { redirect_to @donor, notice: 'Funcionário foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donors/1
  # DELETE /donors/1.json
  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy

    respond_to do |format|
      format.html { redirect_to donors_url }
      format.json { head :no_content }
    end
  end
end
