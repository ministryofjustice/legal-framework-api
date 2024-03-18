class Country < ApplicationRecord
  validates :code, :description, presence: true

  def api_json
    {
      code:,
      description:,
    }.as_json
  end

  def self.populate
    CountriesPopulator.call
    refresh_text_searchable
  end

  def self.refresh_text_searchable
    update_query = <<~UPDATESQL.freeze
      UPDATE countries
      SET searchable =
        setweight(to_tsvector(coalesce(description, '')), 'A');
    UPDATESQL
    connection.execute(update_query)
  end
end
