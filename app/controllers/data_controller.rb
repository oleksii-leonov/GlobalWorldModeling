class DataController < ApplicationController
  def map
    @model = Model.find(params[:id])
    @variables = params[:param]
    
    @dataset = getdataset_map(@variables,@model.id,@model.countries,@model.year)
    respond_to do |format|
      format.xml
    end
  end
  
  def countrymap
    @countries = Country.find(:all, :conditions => {:id => params[:id]})
    
    respond_to do |format|
      format.xml
    end
  end
  
  def countrymap_by_value
    @known_value = KnownValue.find_by_id(params[:id])
    @values = @known_value.country_known_values
    countries = Country.find(:all)
    
    @countries_slovarik ={}
    
    countries.each do |country|
       @countries_slovarik.merge!({country.id => {'name' => country.name, 'name_ammap' => country.name_ammap}})
    end
    
    respond_to do |format|
      format.xml
    end
  end    
  
  def chart
    @model = Model.find(params[:id])
    @variables = params[:param]
   
    @series = getdataset_chart_series(@model.year)
    @dataset = getdataset_chart(@variables,@model.id,@model.countries,@model.year)
    
    respond_to do |format|
      format.xml
    end
  end
  
  def chartsettings
    @model = Model.find(params[:id])
    @variables = params[:param]
    
    @graphs = getchartsetting(@model.countries)
    
    respond_to do |format|
      format.xml
    end
  end
  
  
  
  def getchartsetting(countries=[])
    graphs=[]
  if countries.count < 20
    countries.each do |country|
      graphs << {"gid" => country.id, "title" => country.name}
    end
  end
    graphs << {"gid" => 1000, "title" => "Summary"}
    return graphs
  end

  def getdataset_chart_series(up_to_year)
    series=[]
    (2009..up_to_year).each do |year|
      series << {"xid" => year, "value" => year}
    end
    return series  
  end
  
  def getdataset_chart(variable_id,model_id,countries=[],up_to_year)    
    dataset=[]
    
  if countries.count < 20
    countries.each do |country|
      data_years=[]
      
      (2009..up_to_year).each do |year|
    
         if not variable_value = country.model_variable_values.find(:first, :conditions => ["known_value_id = ? and model_id = ? and year = ?", variable_id, model_id, year])
           variable_value=0
         else
           variable_value=variable_value.value
         end

         data_years << {"xid" => year, "value" => variable_value}      
       end
       
      dataset << {"gid" => country.id, "values" => data_years, "title" => country.name}
    end
  end
  
    data_years=[]
    
    (2009..up_to_year).each do |year|
      if not variable_value = ModelVariableValue.sum(:value,:conditions => ["known_value_id = ? and model_id = ? and year = ?", variable_id, model_id, year])
        variable_value=0
      end

      data_years << {"xid" => year, "value" => variable_value}       
    end
    
    dataset << {"gid" => "1000", "values" => data_years, "title" => "SUM"}
    
    return dataset
  end

  def getdataset_map(variable_id,model_id,countries=[],up_to_year)
    
     dataset=[]
     
     countries = Country.find(:all)
     countries_slovarik ={}
     countries.each do |country|
       countries_slovarik.merge!({country.id => {'name' => country.name, 'name_ammap' => country.name_ammap}})
     end
     
     max_value_all_years = ModelVariableValue.maximum(:value,:conditions => ["known_value_id = ? and model_id = ?", variable_id, model_id])
     

     (2009..up_to_year).each do |year|

       data_countries=[]
       
       country_id_and_variable_array = ModelVariableValue.find(:all,:conditions => ["known_value_id = ? and model_id = ? and year = ?", variable_id, model_id, year])
       
       country_id_and_variable_array.each do |item|    
         
         if not item.value
           variable_value=0
         else
           variable_value=item.value
         end

         data_countries << {"title" => countries_slovarik[item.country_id]["name"],
            "mc_name" => countries_slovarik[item.country_id]["name_ammap"],
            "value" => variable_value.to_s}  
            
       end
       
       data_countries << {"title" => "All years all countries max", "mc_name" => "AA", "value" => max_value_all_years.to_s}
       
       dataset << {"date" => year, "countries" => data_countries}

     end     
    
    return dataset
  end
  
end
