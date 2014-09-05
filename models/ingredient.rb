require_relative '../server'

class Ingredient

 attr_reader :name, :recipe_id

 def initialize(recipe_id,name)
  @recipe_id = recipe_id
  @name = name
 end

end
