class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[ show edit update destroy ]
  before_action :set_recipe, only: %i[create new]  # Dodajemy set_recipe, aby ustawić przepis
  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Ingredient.all
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
    @recipe = Recipe.find(params[:id])
	@ingredient = Ingredient.new(recipe: @recipe)
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients or /ingredients.json
  def create
    if @recipe.ingredients.count >= 3
      flash[:alert] = "You can't add more than 3 ingredients to a recipe."
      redirect_to recipe_path(@recipe) and return
    end

    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.recipe = @recipe

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to recipe_url(@recipe), notice: "Ingredient was successfully created." }
      else
        format.html { redirect_to recipe_url(@recipe), alert: "Failed to create ingredient." }
      end
    end
  end


  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to ingredient_url(@ingredient), notice: "Ingredient was successfully updated." }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: "Ingredient was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :quantity, :recipe_id)
    end
end
