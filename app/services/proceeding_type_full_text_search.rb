# This class is responsible for searching the proceeding types table for matching terms.
#
# It uses Postresql's Full Text Search (see https://www.postgresql.org/docs/9.5/textsearch-intro.html)
#
# Results are currently returned and ranked by relevance, i.e. search terms which appear in
# the additional_search_terms field are ranked higher than those in meaning which in turn are
# ranked higher that those in description.  This is controlled by the ProceedingType.refresh_textsearchable
# method.
#
class ProceedingTypeFullTextSearch
  Result = Struct.new(:meaning, :ccms_code, :description, :ccms_category_law, :ccms_matter)

  def self.call(search_terms, excluded_codes = [])
    new(search_terms, excluded_codes).call
  end

  def initialize(search_terms, excluded_codes = [])
    @excluded_codes = excluded_codes
    @ts_query = ts_query_transform(search_terms)
  end

  def call
    matching_results.delete_if { |result| result.ccms_code.in?(already_selected_codes) }
  end

private

  def already_selected_codes
    @already_selected_codes ||= @excluded_codes.split(',')
  end

  def matching_results
    result_set = ProceedingType.connection.exec_query(query_string,
                                                      '-- PROCEEDING TYPE FULL TEXT SEARCH ---',
                                                      [@ts_query],
                                                      prepare: true)
    result_set.map { |row| instantiate_result(row) }
  end

  def instantiate_result(row)
    Result.new(row['meaning'].strip, row['ccms_code'], row['description'].strip, row['ccms_category_law']&.strip, row['ccms_matter'])
  end

  def ts_query_transform(search_terms)
    # transform the query into a form suitable for postgres to_tsquery function that matches
    # on partial words
    #
    # "An owl & a pussycat went to sea" => "An:* & owl:* & a:* & pussycat:* & went:* & to:* & sea:*"
    #
    words = search_terms.split(/\s+/).map { |w| "#{w}:*" }
    words.join(' & ').gsub('& & &', '&')
  end

  def query_string
    <<~END_OF_QUERY
      SELECT pt.id,#{' '}
        meaning,
        ccms_code,
        description,
        mt.category_of_law as ccms_category_law,
        mt.name as ccms_matter,
        ts_rank(textsearchable, query) AS rank
      FROM proceeding_types pt LEFT OUTER JOIN matter_types mt ON pt.matter_type_id = mt.id, to_tsquery($1) AS query
      WHERE query @@ textsearchable
      ORDER BY rank DESC;
    END_OF_QUERY
  end
end
