class ViewsController < ApplicationController
  def person_view
  end

  def main
    @persons = Person.all
  end
end
