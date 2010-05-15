require 'mathn'
require 'matrix'

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class KnownValuesController < ApplicationController
  load_and_authorize_resource
  
  def loadmanyvalues
     lines = File.readlines("/Users/aleksejleonov/ror/world/public/importers.csv")

     @output = ''
     
     known_countries = Array.new
     
     lines.each do |line|
        country_line = line.match(/([a-zA-Z\'\,\-\.]\s?)+\t/)
        country_name = country_line.to_s.strip
        known_countries.push(country_name)
     end
     
     
     
     lines.each do |line|

       country_line = line.match(/([a-zA-Z\'\,\-\.]\s?)+\t/)
       country_name = country_line.to_s.strip
       importers_output = ''         
       importers_array = ''
       importers_array = country_line.post_match.split(/\,\s/)
         
       @output << "\"" + country_name + "\","
       
       known_countries.each do |country|
          i = 0
          
          importers_array.each do |importer|
             importer_country_name = importer.to_s.match(/([a-zA-Z\'\,\-\.]\s?)+/).to_s.strip
             if (importer_country_name == country) and (i == 0)
               importer_value = importer.to_s.match(/[0-9\,\.\-]+/).to_s
               @output << importer_value.to_s + ","
               i = 1
             end
           end
          
          if i == 0
            
            @output << "0,"
            
          end
          
       end 
     
     
     @output << "\n"
     end

     
     
     countries_header = "\"Country name\","
     known_countries.each do |country|
       countries_header << "\"" + country + "\","
     end
     countries_header << "\n"
     
     @output = countries_header + @output
     
     respond_to do |format|
       format.text # load_many_values.html.erb
     end
   end
  
  
  # GET /known_values
  # GET /known_values.xml
  def index
    @known_values = KnownValue.find(:all, :order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @known_values }
    end
  end

  # GET /known_values/1
  # GET /known_values/1.xml
  def show
    @known_value = KnownValue.find(params[:id])
     
    @countries_values =[]
    
    @known_value.country_known_values.each do |value|
		  country = Country.find(value.country_id)
			@countries_values << {'country' => country,
			  'value' => value.value, 'measurement' => @known_value.unit_measurement}
		end
		
		@countries_values.sort!{ |a,b| a['country'].name.downcase <=> b['country'].name.downcase }
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @known_value }
    end
  end

  # GET /known_values/new
  # GET /known_values/new.xml
  def new
    @known_value = KnownValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @known_value }
    end
  end

  # GET /known_values/1/edit
  def edit
    @known_value = KnownValue.find(params[:id])
  end

  # POST /known_values
  # POST /known_values.xml
  def create
    @known_value = KnownValue.new(params[:known_value])

    respond_to do |format|
      if @known_value.save
        flash[:notice] = "Varible #{@known_value.name} was successfully created."
        format.html { redirect_to(@known_value) }
        format.xml  { render :xml => @known_value, :status => :created, :location => @known_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @known_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /known_values/1
  # PUT /known_values/1.xml
  def update
    @known_value = KnownValue.find(params[:id])

    respond_to do |format|
      if @known_value.update_attributes(params[:known_value])
        
        flash[:notice] = "Varible #{@known_value.name} was successfully updated. "
        
        if @known_value.fill_formula and !(@known_value.fill_formula == "")
          datafill_by_formula(@known_value)
          flash[:notice] << 'Data was calculated by formula.'
        end
        
        if @known_value.uploadfile and !(@known_value.uploadfile == "")
          begin
            flash[:notice] << fill_by_file(@known_value)
          rescue ActiveRecord::StatementInvalid
            flash[:notice] << "<p>There was errors with duplicate countries names. We save only first data finded in file.</p>"
          end
      
        CountryKnownValue.delete_all(:known_value_id => 0)
      
        end
        
        format.html { redirect_to(@known_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @known_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /known_values/1
  # DELETE /known_values/1.xml
  def destroy
    @known_value.country_known_values.delete_all
    @known_value = KnownValue.find(params[:id])
    @known_value.destroy

    respond_to do |format|
      format.html { redirect_to(known_values_url) }
      format.xml  { head :ok }
    end
  end
  
  
private
  
  def datafill_by_formula(known_value)
    
    all_known_values = KnownValue.all
    countries = Country.all
    number_of_countries = countries.count
    
    #Destroy all previuos data
    known_value.country_known_values.delete_all
    
    #Calculate global vars for all countries
    global_vars = ""
    all_known_values.each do |item|
       if summa = item.country_known_values.sum(:value)
         global_vars << "summ_#{item.name_short} = #{summa}; avg_#{item.name_short} = #{summa/number_of_countries}; "
       end
    end
    
    countries.each do |country|
      vars = ""
      vars << global_vars
      all_known_values.each do |item|
          
        if value = country.country_known_values.find_by_known_value_id(item.id)
          value = value.value
        else
          value = 0
        end
        
        vars << "#{item.name_short} = #{value.to_s}; "
      end
      
      vars << known_value.fill_formula
      result = eval(vars)
      
      CountryKnownValue.create(:known_value_id => known_value.id, :country_id => country.id, :year => 2009,
      :value => result)
      
    end
    
    
    return true
  end
  
  
  def fill_by_file(known_value)
    
    
        
    if lines = known_value.uploadfile.read.split(/\r?\n|\r(?!\n)/)
      #Destoy all previous data of this type of values.
      known_value.country_known_values.delete_all
       
      i=0
      countries_not_find = ''
      insert_db_errors = 0
      
      
      lines.each do |line|
        
        country_name = line.match(/([a-zA-Z\'\,\-\.]\s?)+/).to_s.strip
        value = line.match(/[0-9\,\.\-]+$/).to_s.gsub(/\,/,'')

        if entry = Country.find(:first,:conditions => ["name like ?",country_name])
          #Create new country_known_values item in db
          
          begin
            known_value.country_known_values.create(:country_id => entry.id, :value =>value.to_f)
            i += 1
          rescue
            insert_db_errors += 1
            i -= 1
            
          end
          
          
        else
          #We can't find country name in DB
          countries_not_find << "#{country_name} | "
        end    
      end
      
      message = "Succesfully upload #{i} countries."
      message << "<br />But can't find: #{countries_not_find}" if countries_not_find != ''
      message << "<br />Can't insert in db: #{insert_db_errors}" if insert_db_errors > 0

           
    else
      message = "No file!"
    end
    
    return message
 
  end
  
end
