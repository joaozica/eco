# encoding: UTF-8
class DrugTestsController < ApplicationController

  # GET /drug_tests
  # GET /drug_tests.json
  include FilterHelper
  def index
    @drug_tests = DrugTest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drug_tests }
    end
  end

  # GET /drug_tests/1
  # GET /drug_tests/1.json
  def show
    @drug_test = DrugTest.find(params[:id])
     

    respond_to do |format|
      format.png  { render :qrcode => "drug_tests/"+@drug_test.id.to_s}
      format.html # show.html.erb
      format.json { render json: @drug_test }
      format.pdf
    end
  end

  
  def testes_pendentes
    @selections = Selection.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selections }
    end
  end
  def testes_realizados
    @selections = Selection.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selections }
    end
  end

  # GET /drug_tests/new
  # GET /drug_tests/new.json
  def new
    @drug_test = DrugTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drug_test }
    end
  end

  # GET /drug_tests/1/edit
  def edit
    @drug_test = DrugTest.find(params[:id])
  end

  # POST /drug_tests
  # POST /drug_tests.json
  def create
    @drug_test = DrugTest.new(params[:drug_test])
    @test_types = params[:test_types]
    @test_types_all = []
    @test_types.each do |id|  
     @test_types_all +=[TestType.find_by_id(id)]
    end
    @drug_test.test_types=@test_types_all
    respond_to do |format|
      
      if @drug_test.save
        format.html { redirect_to @drug_test, notice: 'Teste de droga foi criado com sucesso.' }
        format.json { render json: @drug_test, status: :created, location: @drug_test }
      else
        format.html { render action: "new" }
        format.json { render json: @drug_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drug_tests/1
  # PUT /drug_tests/1.json
  def update
    @drug_test = DrugTest.find(params[:id])
    @tests = params[:tests]
    
    @updates = Hash.new
    if not @tests.blank?
      @tests.each do |t|
        @selected_test = SelectedTest.find_by_id(t[:id])
        if @selected_test.completed_at.blank?
          if t[:result] != ""
            @updates[t[:id].to_i] = {:result => t[:result], :completed_at => Time.now}
          end
        end
      end
    end
    exame_responsible = params[:selection][:exame_responsible]
    
    respond_to do |format|
      if not exame_responsible.blank?
      @drug_test.selection.exame_responsible = exame_responsible
      @drug_test.selection.save
      end
      @drug_test.update_attributes(params[:drug_test])
         if SelectedTest.update(@updates.keys, @updates.values) 

          format.html { redirect_to @drug_test, notice: 'Teste de droga foi atualizado com sucesso.' }
          format.json { head :no_content }
        else
          format.html { render action: "show" }
          format.json { render json: @drug_test.errors, status: :unprocessable_entity }
        end
    end
      
      
  end

  # DELETE /drug_tests/1
  # DELETE /drug_tests/1.json
  def destroy
    @drug_test = DrugTest.find(params[:id])
    @drug_test.destroy

    respond_to do |format|
      format.html { redirect_to drug_tests_url }
      format.json { head :no_content }
    end
  end

  def relatorio
    
  end

  def result_relatorio
    result = params[:result_test]
    result = result.downcase
    test_type_id = params[:test_type_id]
    #test_type_id = test_type_id.upcase
    scheduled_i = params[:date_ia]
    scheduled_f = params[:date_fa]
    donor = params[:donor_id]
    company_id = params[:company_id]
    
    if scheduled_i != ""
     scheduled_inicio = DateTime.parse(scheduled_i)
    end
    if scheduled_f != ""
      scheduled_fim = DateTime.parse(scheduled_f) + 1.day - 1.minute
    end
    
    filter(company_id ,donor,test_type_id, result, "", "", scheduled_inicio, scheduled_fim)

  end
end
