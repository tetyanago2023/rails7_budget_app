module CategoriesHelper
  def tailwind_color(category)
    color_variants = {
      rose: 'bg-rose-400 hover:bg-rose-400',
      light_blue: 'bg-sky-400 hover:bg-sky-400',
    }
    if category.present? && category.color.present?
      color_variants[category.color.to_sym]
    else
      'bg-gray-100 hover:bg-gray-100'
    end
  end
end
