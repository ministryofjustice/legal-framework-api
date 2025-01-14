class ProceedingTypeFilter
  def initialize(current_proceedings = [], allowed_categories = [], search_term = "")
    @current_proceedings = current_proceedings
    @allowed_categories = allowed_categories
    @search_term = search_term
    @results = @search_term.present? ? ProceedingTypeFullTextSearch.call(search_term) : ProceedingType.all.map(&:api_json)
  end

  def self.call(current_proceedings = [], allowed_categories = [], search_term = "")
    new(current_proceedings, allowed_categories, search_term).call
  end

  def call
    configure_sca_proceedings!
    configure_plf_proceedings!
    reject_current_proceedings!
    reject_categories! unless @allowed_categories.empty?
    @results
  end

private

  def reject_current_proceedings!
    @results.delete_if { |result| result["ccms_code"].in?(@current_proceedings) }
  end

  def configure_sca_proceedings!
    @results.delete_if do |result|
      if @current_proceedings.empty? # if current_proceedings is empty, only show SCA core
        result["sca_related"] && result["ccms_matter_code"].eql?("KPBLW")
      elsif current_proceedings_have_sca # if already has an SCA proceeding, exclude all non-SCA proceedings
        result["sca_related"].eql?(false) && result["sca_core"].eql?(false)
      else
        result["sca_related"] || result["sca_core"]
      end
    end
  end

  def configure_plf_proceedings!
    return unless current_proceedings_have_plf

    @results.delete_if do |proceeding|
      [
        proceeding_is_not_plf?(proceeding), # if already has an PLF proceeding, exclude all non-PLF proceedings
        has_means_test_plf_mismatch?(proceeding),
      ].any?
    end
  end

  def reject_categories!
    @results.delete_if { |result| !result["ccms_category_law_code"].in?(@allowed_categories) }
  end

  def current_proceedings_have_sca
    @current_proceedings_have_sca ||= ProceedingType.where(ccms_code: @current_proceedings).any? do |proceeding|
      proceeding["sca_core"] || proceeding["sca_related"]
    end
  end

  def proceeding_is_not_plf?(proceeding)
    proceeding["ccms_code"].match?("^(?!PBM)")
  end

  def has_means_test_plf_mismatch?(proceeding)
    proceeding["non_means_tested_plf"] != current_proceedings_have_non_means_tested_plf
  end

  def current_proceedings_have_plf
    @current_proceedings_have_plf ||= ProceedingType.where(ccms_code: @current_proceedings).any? do |proceeding|
      proceeding["ccms_code"].match?("^PBM")
    end
  end

  def current_proceedings_have_non_means_tested_plf
    @current_proceedings_have_non_means_tested_plf ||= ProceedingType.where(ccms_code: @current_proceedings, non_means_tested_plf: true).any?
  end
end
