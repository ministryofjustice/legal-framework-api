# This class is responsible for searching the countries table for matching terms.
#
# It uses Postgresql's Full Text Search (see https://www.postgresql.org/docs/9.5/textsearch-intro.html)
#
# Results are currently returned and ranked by name and [plain english] country name. see the migration
# which creates and stores the generated value.
#
# Partial word/term matching is achieved by adding a wildcard to the end of each term
#
class CountriesFullTextSearch
  Result = Struct.new(:description, :code, :description_headline)

  def self.call(search_terms)
    new(search_terms).call
  end

  def initialize(search_terms)
    @ts_query = ts_query_transform(search_terms)
  end

  def call
    matching_results
  end

private

  def matching_results
    qs = query_string
    result_set = Country.connection.exec_query(qs,
                                               "-- COUNTRIES FULL TEXT SEARCH ---",
                                               [@ts_query],
                                               prepare: true)
    result_set.map { |row| instantiate_result(row) }
  end

  def instantiate_result(row)
    Result.new(row["description"].strip, row["code"], row["description_headline"])
  end

  def ts_query_transform(search_terms)
    # transform the query into a form suitable for postgres to_tsquery function that matches
    # on partial words
    #
    # "An owl & a pussycat went to sea" => "An:* & owl:* & a:* & pussycat:* & went:* & to:* & sea:*"
    #
    words = search_terms.split(/\s+/).map { |w| "#{w}:*" }
    words.join(" & ").gsub("& & &", "&")
  end

  def query_string
    <<~SQL.squish
      SELECT
        countries.code,
        countries.description,
        ts_rank(searchable, query) AS rank,
        ts_headline(
          'simple',
          countries.description,
          query,
          'HighlightAll=true, StartSel=<mark>, StopSel=</mark>'
        ) as description_headline
      FROM countries,
           to_tsquery('simple', $1) AS query
      WHERE query @@ searchable
      ORDER BY rank DESC;
    SQL
  end
end
