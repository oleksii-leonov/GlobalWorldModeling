class CountryKnownValuesController < ApplicationController
  # GET /country_known_values
  # GET /country_known_values.xml
  def index
    @country_known_values = CountryKnownValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @country_known_values }
    end
  end

  # GET /country_known_values/1
  # GET /country_known_values/1.xml
  def show
    @country_known_value = CountryKnownValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country_known_value }
    end
  end

  # GET /country_known_values/new
  # GET /country_known_values/new.xml
  def new
    @country_known_value = CountryKnownValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @country_known_value }
    end
  end

  # GET /country_known_values/1/edit
  def edit
    @country_known_value = CountryKnownValue.find(params[:id])
  end

  # POST /country_known_values
  # POST /country_known_values.xml
  def create
    @country_known_value = CountryKnownValue.new(params[:country_known_value])

    respond_to do |format|
      if @country_known_value.save
        flash[:notice] = 'CountryKnownValue was successfully created.'
        format.html { redirect_to(@country_known_value) }
        format.xml  { render :xml => @country_known_value, :status => :created, :location => @country_known_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country_known_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /country_known_values/1
  # PUT /country_known_values/1.xml
  def update
    @country_known_value = CountryKnownValue.find(params[:id])

    respond_to do |format|
      if @country_known_value.update_attributes(params[:country_known_value])
        flash[:notice] = 'CountryKnownValue was successfully updated.'
        format.html { redirect_to(@country_known_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country_known_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /country_known_values/1
  # DELETE /country_known_values/1.xml
  def destroy
    @country_known_value = CountryKnownValue.find(params[:id])
    @country_known_value.destroy

    respond_to do |format|
      format.html { redirect_to(country_known_values_url) }
      format.xml  { head :ok }
    end
  end
end
