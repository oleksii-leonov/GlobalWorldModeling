# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100219103634) do

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "name_ammap"
  end

  create_table "countries_models", :id => false, :force => true do |t|
    t.integer "model_id"
    t.integer "country_id"
  end

  add_index "countries_models", ["model_id", "country_id"], :name => "index_models_countries_on_model_id_and_country_id", :unique => true
  add_index "countries_models", ["model_id"], :name => "index_models_countries_on_model_id"

  create_table "country_known_values", :force => true do |t|
    t.integer "country_id",                       :null => false
    t.integer "known_value_id",                   :null => false
    t.float   "value",                            :null => false
    t.integer "year",           :default => 2009, :null => false
  end

  add_index "country_known_values", ["country_id", "known_value_id", "year"], :name => "mybigindex", :unique => true
  add_index "country_known_values", ["country_id", "known_value_id"], :name => "mysmallindex"
  add_index "country_known_values", ["country_id"], :name => "index_country_known_values_on_country_id"
  add_index "country_known_values", ["known_value_id"], :name => "known_value_id"

  create_table "known_values", :force => true do |t|
    t.string "name"
    t.string "name_short"
    t.string "unit_measurement"
    t.text   "description"
    t.text   "fill_formula"
    t.string "source_name"
  end

  create_table "known_values_models", :id => false, :force => true do |t|
    t.integer "model_id",       :null => false
    t.integer "known_value_id", :null => false
  end

  add_index "known_values_models", ["model_id", "known_value_id"], :name => "index_known_values_models_on_model_id_and_known_value_id", :unique => true
  add_index "known_values_models", ["model_id"], :name => "index_known_values_models_on_model_id"

  create_table "model_variable_values", :force => true do |t|
    t.integer "known_value_id", :null => false
    t.integer "country_id",     :null => false
    t.float   "value",          :null => false
    t.integer "year",           :null => false
    t.integer "model_id",       :null => false
  end

  add_index "model_variable_values", ["model_id", "known_value_id", "country_id", "year"], :name => "my_bigindex", :unique => true
  add_index "model_variable_values", ["model_id", "known_value_id", "year"], :name => "my_sum_bigindex"
  add_index "model_variable_values", ["model_id"], :name => "index_model_variable_values_on_model_id"

  create_table "models", :force => true do |t|
    t.string   "name"
    t.text     "formula"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "variables_map"
    t.string   "variables_chart"
    t.text     "description"
  end

end
