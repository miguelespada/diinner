class MultiModelSearch
  def self.search query
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
     Elasticsearch::Model.search(query, [Restaurant, User]).results
  end
end