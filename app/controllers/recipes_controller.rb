class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :authorize_recipe, only: [:update]
  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end
  
  def authorize_recipe
    authorize @recipe, :update?
  end

  # GET /recipes/1 or /recipes/1.json
  def show
	@recipe = Recipe.find(params[:id])
	@ingredient = Ingredient.new(recipe: @recipe)

  respond_to do |format|
	format.html
	format.json do
	  render json: {
		id: @recipe.id,
		title: @recipe.title,
		description: @recipe.description,
		content: @recipe.content.to_plain_text, # lub .body.to_s jeśli chcesz HTML
		creator_id: @recipe.creator_id,
		ingredients: @recipe.ingredients.map(&:name),
		created_at: @recipe.created_at,
		updated_at: @recipe.updated_at
	  }
	end
  end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new(creator: current_user)
  end

  # GET /recipes/1/edit
  def edit
  end

def create
  @recipe = Recipe.new(recipe_params)

  respond_to do |format|
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully created." }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @recipe.update(recipe_params)
      format.html { redirect_to recipe_url(@recipe), notice: "Recipe was successfully updated." }
      format.json { render :show, status: :ok, location: @recipe }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end
end


  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :description, :content, :creator_id)
    end
end

