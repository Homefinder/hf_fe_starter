class HomesController < ApplicationController
  PER_PAGE = 20

  before_filter :build_default_query, only: [:index]
  before_filter :build_query, only: [:search]
  before_filter :execute_query
  before_filter :calculate_pagination

  def index
  end

  def search
  end

private

  def build_query
    @terms = {
      area:  params[:area],
    }

    if max = params[:max]
      @terms[:price] = "* TO #{max}"
    end
  end

  def build_default_query
    @terms = {
      area: "Chicago, IL"
    }
  end

  def execute_query
    begin
      @listings, @meta = Homefinder.search(@terms)
    rescue => e
      logger.error e

      @no_results = true
    end
  end

  def calculate_pagination
    return if @no_results

    page_index = @meta["currentPage"]

    @first_index = (PER_PAGE * (page_index - 1)) + 1
    @last_index = PER_PAGE * page_index
    @total = @meta["totalMatched"]
  end

end

