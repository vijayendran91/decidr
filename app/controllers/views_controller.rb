class ViewsController < ApplicationController
  def main
    @persons = Person.order("#{params[:sort_by] || 'first_name'} #{params[:order] || 'asc'}")
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
