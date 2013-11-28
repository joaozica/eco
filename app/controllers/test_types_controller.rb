class TestTypesController < ApplicationController
  # GET /test_types
  # GET /test_types.json
  before_filter :checked_user
  def index
    @test_types = TestType.order("name").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_types }
    end
  end

  # GET /test_types/1
  # GET /test_types/1.json
  def show
    @test_type = TestType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_type }
    end
  end

  # GET /test_types/new
  # GET /test_types/new.json
  def new
    @test_type = TestType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_type }
    end
  end

  # GET /test_types/1/edit
  def edit
    @test_type = TestType.find(params[:id])
  end

  # POST /test_types
  # POST /test_types.json
  def create
    @test_type = TestType.new(params[:test_type])

    respond_to do |format|
      if @test_type.save
        format.html { redirect_to @test_type, notice: 'Tipo de Teste foi criado com sucesso.' }
        format.json { render json: @test_type, status: :created, location: @test_type }
      else
        format.html { render action: "new" }
        format.json { render json: @test_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_types/1
  # PUT /test_types/1.json
  def update
    @test_type = TestType.find(params[:id])

    respond_to do |format|
      if @test_type.update_attributes(params[:test_type])
        format.html { redirect_to @test_type, notice: 'Tipo de Teste foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_types/1
  # DELETE /test_types/1.json
  def destroy
    @test_type = TestType.find(params[:id])
    @test_type.destroy

    respond_to do |format|
      format.html { redirect_to test_types_url }
      format.json { head :no_content }
    end
  end
end
