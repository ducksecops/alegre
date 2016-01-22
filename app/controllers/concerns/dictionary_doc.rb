#encoding: utf-8 
# :nocov:
module DictionaryDoc
  extend ActiveSupport::Concern
 
  included do
    swagger_controller :dictionary, 'Dictionary'

    swagger_api :terms do
      summary 'Get dictionary terms (from Babelfy for the first time, then from ElasticSearch) for a text in a certain language'
      notes 'Get dictionary terms (from Babelfy for the first time, then from ElasticSearch) for a text in a certain language'
      param :query, :text, :string, :required, 'Text to be searched'
      param :query, :language, :string, :required, 'Source language of the text'
      param :query, :source_id, :string, :optional, 'An identifier of the input text (e.g., a post ID on Bridge)'
      authed = { 'Authorization' => 'Token token="test"' }
      response :ok, 'Terms from dictionary', { query: { text: 'The book is on the table', lang: 'en', source_id: 'x' }, headers: authed }
      response 400, 'Missing parameters', { query: nil, headers: authed }
      response 400, 'Invalid language format', { query: { text: 'Test', lang: 'en_US', source_id: 'x' }, headers: authed }
      response 401, 'Access denied', { query: { text: 'Test', lang: 'en', source_id: 'x' } }
    end

  end
end
# :nocov:
