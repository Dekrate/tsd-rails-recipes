class Recipe < ApplicationRecord
  has_rich_text :content
  belongs_to :creator, class_name: "User"
  has_many :ingredients
  validate :ingredient_limit

  private

  # Walidacja, która sprawdza, czy liczba składników nie przekracza 3
  def ingredient_limit
    if ingredients.size > 3
      errors.add(:ingredients, "cannot have more than 3 ingredients.")
    end
  end
end