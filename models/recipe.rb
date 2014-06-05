class Recipe
  attr_reader :id, :name, :description, :instructions

  def self.all
    @recipes = []

    connection = PG::Connection.open(dbname: 'recipes')
      recipe_data = connection.exec( "SELECT * FROM recipes" )
    connection.close

    recipe_data.each do |recipe|
      @recipes << Recipe.new(recipe["id"], recipe["name"], recipe["description"], recipe["instructions"])
    end

    @recipes
  end

  def initialize(id, name, description, instructions)
    @id = id
    @name = name
    @description = description
    @instructions = instructions
  end

  def self.find(id)
    @recipes.each do |recipe|
      if recipe.id == id
        return recipe
      end
    end
  end

  def ingredients
    ingredients = []
    all_ingredients = Ingredient.all
    all_ingredients.each do |ingredient|
      if recipe_id = id
        ingredients << ingredient
      end
    end
    ingredients
  end
end
