# encoding: UTF-8
class SelectionsController < ApplicationController
  # GET /selections
  # GET /selections.json
  def index
    @selections = Selection.order("name asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @selections }
    end
  end

  # GET /selections/1
  # GET /selections/1.json
  def show
    @selection = Selection.find(params[:id])
    @drug_test = DrugTest.where("selection_id = ?", @selection.id)

    respond_to do |format|
      format.html # show.html.erb
      format.csv { send_data @drug_test.to_csv }
      format.json { render json: @selection }
      format.xls #{ send_data @selection.to_csv(col_sep: "\t"),:filename => 'products.xls'  }
    end
  end

  # GET /selections/new
  # GET /selections/new.json
  def new
    @selection = Selection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selection }
    end
  end

  # GET /selections/1/edit
  def edit
    @selection = Selection.find(params[:id])
    if @selection.criteria == "aleatorio" 
      @criteria = "Aleatório"
    elsif @selection.criteria == "por historico"
      @criteria = "Por histórico"
    elsif @selection.criteria == "motivado"
      @criteria = "Motivado"
    end
      
  end

  # POST /selections
  # POST /selections.json
  def create
    @selection = Selection.new(params[:selection])

    respond_to do |format|
      if @selection.save
        format.html { redirect_to @selection, notice: 'Seleção foi criada com sucesso.' }
        format.json { render json: @selection, status: :created, location: @selection }
      else
        format.html { render action: "new" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /selections/1
  # PUT /selections/1.json
  def update
    @selection = Selection.find(params[:id])

    respond_to do |format|
      if @selection.update_attributes(params[:selection])
        format.html { redirect_to @selection, notice: 'Seleção foi atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selections/1
  # DELETE /selections/1.json
  def destroy
    @selection = Selection.find(params[:id])
    @donor_test = DrugTest.joins("INNER JOIN donors d on d.id = drug_tests.donor_id").where("selection_id = ?", @selection.id)
      if not @donor_test.empty? 
      @donor_test.each do |drug_test|
        @selected_tests = drug_test.selected_test.all
        @selected_tests.each do |test|
          test.destroy
        end
        drug_test.destroy
      end
    else
    @selection.destroy
    end

    respond_to do |format|
      format.html { redirect_to selections_url }
      format.json { head :no_content }
    end
  end
  def selection_by_historical
    @selection = Selection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selection }
    end
  end
  def selection_random
     @selection = Selection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selection }
    end
  end
  def selection_motivado
     @selection = Selection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selection }
    end
  end
  def selection_motivado_new
    selection_name = params[:name]
    selection_criteria = params[:criteria]
    selection_company = Company.find_by_id(params[:company_id])
    selection_responsible = params[:selection][:selection_responsible]

    @test_types_all = []
    @test_types = params[:test_types]
    @test_types.each do |id|  
      @test_types_all +=[TestType.find_by_id(id.to_i)]
    end

    @donors_all = []
    @donors = params[:donor_id]
    @donors.each do |id|  
     @donors_all +=[Donor.find_by_id(id)]
    end

    selection_donor_all = @donors_all
    selection_test_type=@test_types_all
    selection_amount = params[:amount]
    scheduled_to  = DateTime.new(params["scheduled_to(1i)"].to_i, 
                        params["scheduled_to(2i)"].to_i,
                        params["scheduled_to(3i)"].to_i)

   @created_selection = Selection.create_with_random_employees(selection_responsible,selection_name,selection_criteria, selection_company, selection_test_type, "M", selection_amount,scheduled_to, selection_donor_all)
    respond_to do |f|
      f.html { render "/selections/success_selection"}
    end
  end

  def selection_by_historical_new
    selection_name = params[:name]
    selection_criteria = params[:criteria]
    selection_company = Company.find_by_id(params[:company_id])
    selection_responsible = params[:selection][:selection_responsible]

    
    @test_types_all = []
    @test_types = params[:test_types]
    @test_types.each do |id|  
      @test_types_all +=[TestType.find_by_id(id.to_i)]
    end

    donors = []
    selection_test_type=@test_types_all
    selection_amount = params[:amount]
    scheduled_to  = DateTime.new(params["scheduled_to(1i)"].to_i, 
                        params["scheduled_to(2i)"].to_i,
                        params["scheduled_to(3i)"].to_i)

    @created_selection = Selection.create_with_random_employees(selection_responsible,selection_name,selection_criteria, selection_company, selection_test_type, "B", selection_amount,scheduled_to, donors)
    respond_to do |f|
      f.html { render "/selections/success_selection"}
    end
  end
  def selection_random_new
    selection_name = params[:name]
    selection_criteria = params[:criteria]
    selection_company = Company.find_by_id(params[:company_id])
    selection_responsible = params[:selection][:selection_responsible]
    
    @test_types_all = []
    @test_types = params[:test_types]
    @test_types.each do |id|  
      @test_types_all +=[TestType.find_by_id(id.to_i)]
    end

    donors = []

    selection_test_type=@test_types_all
    selection_amount = params[:amount]
    scheduled_to  = DateTime.new(params["scheduled_to(1i)"].to_i, 
                        params["scheduled_to(2i)"].to_i,
                        params["scheduled_to(3i)"].to_i)

    @created_selection = Selection.create_with_random_employees(selection_responsible,selection_name,selection_criteria, selection_company, selection_test_type, "R", selection_amount,scheduled_to, donors)
    respond_to do |f|
      f.html { render "/selections/success_selection"}
    end
  end
end
