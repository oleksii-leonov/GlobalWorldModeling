require 'mathn'
require 'matrix'

class Matrix
    def []=(i, j, x)
      @rows[i][j] = x
    end
  end

class ModelFillDataController < ApplicationController
  
  def matrix

    

    #require 'benchmark'
    
    raise "Please, set correct model_id!" if not Model.find(params[:id])
    
    

    
    #Find our model
    model = Model.find(params[:id])
    
    authorize! :manage, model
    
    #Destroy old results  
    #@model.model_variable_values.destroy_all
    ModelVariableValue.delete_all(:model_id => model.id)
    
    #Analyze formula - search for variables
    vars = model.formula.scan(/[a-z\_]{3,}/)
    
    #Find countries, that included in model - making hash
    country_slovarik ={}
    j=0
    model.countries.each do |country|
      country_slovarik.merge!({j => country.id})
      j += 1
    end
    
    #Set formula   
    formula = " { #{model.formula} }; "
    
    known_values = KnownValue.find(:all)
    values_slovarik ={}
    known_values.each do |item|
      if vars.include?(item.name_short)
        values_slovarik.merge!({item.name_short => item.id})
      end
    end
    
    #Set a set of known_values that we need to save
    set_known_values = Set.new
    model.known_values.each do |known_value|
      set_known_values.add(known_value.id)
    end
    
    
    #countries = Country.find(:all, :order => "id")
    input_values = []
    
    country_slovarik.each_value do |country_id|
      temp = []
      values_slovarik.each_value do |known_value_id|
        if temp1 = CountryKnownValue.find(:first,
            :conditions => ['country_id = ? and known_value_id = ?',country_id,known_value_id])
          temp << temp1.value
        else
          temp << 0
        end
      end
      input_values << temp
    end
   
    data_matrix = Matrix.rows(input_values)

number_of_countries = model.countries.count
number_of_variables = values_slovarik.count
sql = "INSERT INTO model_variable_values (country_id,known_value_id,value,year,model_id) VALUES "
model_id = model.id

begin_world_variables = ""

j=0
values_slovarik.each do |key,value|
  summa = 0 
  (1..number_of_countries).each do |i|
    summa += data_matrix[i-1,j]
  end
    j += 1 
    
    begin_world_variables << "summ_#{key}_0 = #{summa}; "
end



#Make calculations for number of steps   
(2009..model.year).each do |year|
   
   world_variables = "year=#{year}; "
   world_variables << begin_world_variables
   
   #calculate global summary variables
   j=0
   values_slovarik.each do |key,value|
     summa = 0
     
     0.upto(number_of_countries-1) do |i|
      summa += data_matrix[i,j]
     end
     
     j += 1
     
     world_variables << "summ_#{key} = #{summa}; "
   end
   
   
   if year > 2009
   
     #calculating next step data based on previous data in matrix for each country
     0.upto(number_of_countries-1) do |i|
      
       vars = ""
       vars << world_variables
       
       j = 0
       values_slovarik.each_key do |key|
         vars << "#{key} = #{data_matrix[i,j]}; "
         j += 1
       end
       
       vars << formula
       results = eval(vars)
      
       j = 0
       values_slovarik.each_key do |key|

         if results.include?(key)         
           data_matrix[i,j] = results[key].to_f
         end
         
         j += 1
       end
             
     end
   
   end
    
    
    #write our prognosed data in DB (model_variables_values)
    country_slovarik.each do |country_key,country_id|
      j = 0
      values_slovarik.each_value do |value|
        if set_known_values.include?(value)
          sql << "(#{country_id},#{value},#{data_matrix[country_key,j]},#{year},#{model_id}),"
        end
        j += 1
      end
      
    end
end      

      #@model.model_variable_values.create(:country_id => country.id, :known_value_id =>j, :value => element, :year => (2009+step))
      sql.sub!(/,$/, '')
      ActiveRecord::Base.connection.execute(sql)
      flash[:notice] = "Data succesfully calculated."
      redirect_to(:controller => "models", :action => "show", :id => model)

  end

end
