require_relative '../server'
require_relative 'ingredient'
require 'pry'
require 'sinatra'
require 'pg'

class Recipe
  attr_reader :id, :name, :instructions, :description, :ingredients

  def initialize(id,name,instructions,description, ingredients = [])
   @id = id
   @name = name
   @instructions = instructions
   @description = description
   @ingredients = ingredients
  end




def self.all
  @recipes = []
  recipes = db_connection do |conn|
              conn.exec("SELECT * FROM recipes")
            end
  recipes = recipes.to_a
  recipes.each do |data|
     @recipes << Recipe.new(data["id"],data["name"],data["instructions"], data["description"])
     end
  @recipes
  end


def self.find_ingredients(id)
@ingredients =[]
food_list = db_connection do |conn|
              conn.exec("SELECT * FROM ingredients WHERE recipe_id = $1", [id])
              end
food_list = food_list.to_a
food_list.each do |food|
    @ingredients << Ingredient.new(food["recipe_id"], food["name"])
     end
  #binding.pry
  @ingredients
  end


def self.find(id)
#binding.pry
info =  db_connection do |conn|
            conn.exec("SELECT recipes.id,recipes.name,recipes.description, recipes.instructions FROM recipes
            WHERE recipes.id = $1", [id])
          end
 #binding.pry
 info = info.to_a
 #binding.pry
  #binding.pry
  recipe_ing = find_ingredients(id)
  #binding.pry
  @recipe = Recipe.new(info[0]["id"],info[0]["name"],info[0]["instructions"], info[0]["description"], recipe_ing)
  #end
  #binding.pry

end









end
