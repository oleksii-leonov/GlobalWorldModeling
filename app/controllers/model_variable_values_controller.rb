class ModelVariableValuesController < ApplicationController
  load_and_authorize_resource
  
  # GET /model_variable_values
  # GET /model_variable_values.xml
  def index
    @model_variable_values = ModelVariableValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @model_variable_values }
    end
  end

  # GET /model_variable_values/1
  # GET /model_variable_values/1.xml
  def show
    @model_variable_value = ModelVariableValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model_variable_value }
    end
  end

  # GET /model_variable_values/new
  # GET /model_variable_values/new.xml
  def new
    @model_variable_value = ModelVariableValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model_variable_value }
    end
  end

  # GET /model_variable_values/1/edit
  def edit
    @model_variable_value = ModelVariableValue.find(params[:id])
  end

  # POST /model_variable_values
  # POST /model_variable_values.xml
  def create
    @model_variable_value = ModelVariableValue.new(params[:model_variable_value])

    respond_to do |format|
      if @model_variable_value.save
        flash[:notice] = 'ModelVariableValue was successfully created.'
        format.html { redirect_to(@model_variable_value) }
        format.xml  { render :xml => @model_variable_value, :status => :created, :location => @model_variable_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model_variable_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /model_variable_values/1
  # PUT /model_variable_values/1.xml
  def update
    @model_variable_value = ModelVariableValue.find(params[:id])

    respond_to do |format|
      if @model_variable_value.update_attributes(params[:model_variable_value])
        flash[:notice] = 'ModelVariableValue was successfully updated.'
        format.html { redirect_to(@model_variable_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model_variable_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /model_variable_values/1
  # DELETE /model_variable_values/1.xml
  def destroy
    @model_variable_value = ModelVariableValue.find(params[:id])
    @model_variable_value.destroy

    respond_to do |format|
      format.html { redirect_to(model_variable_values_url) }
      format.xml  { head :ok }
    end
  end
end
