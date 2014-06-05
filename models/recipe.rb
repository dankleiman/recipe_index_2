class Recipe
  attr_reader :id, :name
  def self.all
    recipes = []

    connection = PG::Connection.open(dbname: 'recipes')
      recipe_data = connection.exec( "SELECT * FROM recipes" )
    connection.close

    recipe_data = recipe_data.to_a
    recipe_data.each do |recipe|
      recipes << Recipe.new(recipe["id"], recipe["name"])
    end

    recipes
  end

  def initialize(id, name)
    @id = id
    @name = name
  end
end
