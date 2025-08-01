class ViewsController < ApplicationController
  def main
    category = params[:category]
    page = params[:page]
    if category.blank?
      @persons = Person.order("#{params[:sort_by] || 'first_name'} #{params[:order] || 'asc'}").page(page).per(10)
    else
      if category == "locations"
        @persons = Person.joins(:locations)
                        .where("locations.name ILIKE ?", "%#{params[:query]}%")
                        .page(page).per(10)
                        .distinct
      elsif category == "affiliations"
        @persons = Person.joins(:affiliations)
                        .where("affiliations.name ILIKE ?", "%#{params[:query]}%")
                        .page(page).per(10)
                        .distinct
      else
        @persons = Person.where("#{category} ILIKE ?", "%#{params[:query]}%")
                         .page(page).per(10)
      end
    end

    @columns = format_column_names(Person.column_names.dup)
    respond_to do |format|
      format.html
      format.json do
        render json: {
          html: render_to_string(partial: "views/person_rows", locals: { persons: @persons, columns: @columns }, formats: [ :html ])
        }
      end
    end
  end

  private
  def format_column_names(columns)
    columns.delete("id")
    columns.delete("created_at")
    columns.delete("updated_at")
    columns
  end
end
