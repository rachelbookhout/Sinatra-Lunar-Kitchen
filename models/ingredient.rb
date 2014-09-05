require_relative '../server'

class Ingredient
 attr_reader :name, :recipe_id
 def initialize(recipe_id,name)
  @recipe_id = recipe_id
  @name = name
end

 def find_ingredients(recipe_id)
@ingredients =[]
food_list = db_connection do |conn|
              conn.exec("SELECT * FROM ingredients WHERE recipes.id = $1", [id])
              end
food_list = food_list.to_a
food_list.each do |food|
    @ingredients << Ingredient.new(food["recipe_id"], food["name"])
     end
  @ingredients
  end

end
