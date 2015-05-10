class MultiModelSearch
  
  def self.search query, page, per_page = 25
    query = Jbuilder.encode do |json|
          json.query do
            json.match do
              json._all do
                json.query query
                json.fuzziness 5
                json.prefix_length 3
              end
            end
          end
        end
    multimodel = Elasticsearch::Model.search(query, [Restaurant, User]).per_page(per_page).page(page).results
  end
end