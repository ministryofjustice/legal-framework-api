class ProceedingTypeFilter
  def initialize(current_proceedings = [], allowed_categories = [], search_term = "")
    @current_proceedings = current_proceedings
    @allowed_categories = allowed_categories
    @search_term = search_term
    @results = ProceedingType.all.map(&:api_json)
  end

  def self.call(current_proceedings = [], allowed_categories = [], search_term = "")
    new(current_proceedings, allowed_categories, search_term).call
  end

  def call
    configure_sca_proceedings!
    reject_current_proceedings!
    reject_categories! unless @allowed_categories.empty?
    @results
  end

private

  def reject_current_proceedings!
    @results.delete_if { |result| result["ccms_code"].in?(@current_proceedings) }
  end

  def configure_sca_proceedings!
    if @current_proceedings.empty? # if current_proceedings is empty, only show SCA core
      @results.delete_if { |result| result["sca_related"] && result["ccms_matter_code"].eql?("KPBLW") }
    elsif !current_proceedings_have_sca
      @results.delete_if { |result| result["sca_related"] || result["sca_core"] }
    elsif current_proceedings_have_sca
      @results.delete_if { |result| result["sca_related"].eql?(false) && result["sca_core"].eql?(false) }
    end
  end

  def reject_categories!
    @results.delete_if { |result| !result["ccms_category_law_code"].in?(@allowed_categories) }
  end

  def current_proceedings_have_sca
    @current_proceedings_have_sca ||= ProceedingType.where(ccms_code: @current_proceedings).any? { |proceeding| proceeding["sca_core"] || proceeding["sca_related"] }
  end
end
