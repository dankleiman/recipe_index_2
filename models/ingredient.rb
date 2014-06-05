class Ingredient
  attr_reader :id, :name, :recipe_id

  def self.all
    @ingredients = []

    connection = PG::Connection.open(dbname: 'recipes')
      ingredient_data = connection.exec( "SELECT * FROM ingredients" )
    connection.close

    ingredient_data.each do |ingredient|
      @ingredients << Ingredient.new(ingredient["id"], ingredient["name"], ingredient["recipe_id"])
    end

    @ingredients
  end

  def initialize(id, name, recipe_id)
    @id = id
    @name = name
    @recipe_id = recipe_id
  end
end
