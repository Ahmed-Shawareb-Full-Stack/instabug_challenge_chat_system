require "elasticsearch/model"

class Message < ApplicationRecord
  belongs_to :chat
  validates :content, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # Set the Elasticsearch index name dynamically
  index_name Rails.application.class.module_parent_name.underscore

  # Elasticsearch settings and mapping
  settings index: { number_of_shards: 1, number_of_replicas: 1 } do
    mapping dynamic: "false" do
      indexes :chat_id, type: "keyword"  # Using 'keyword' for exact matches
      indexes :content, type: "text", analyzer: "english"  # 'text' type for full-text search
    end
  end

  # Customize JSON representation for Elasticsearch indexing
  def as_indexed_json(options = {})
    as_json(only: [ :chat_id, :content ])
  end

  # Custom search method for searching messages within a chat
  def self.search(chat_id, query)
    query = sanitize_query(query)
    query_terms_count = query.split.length

    __elasticsearch__.search(
      min_score: query_terms_count == 1 ? 1.0 : 2.0,
      query: {
        bool: {
          must: {
            query_string: {
              query: "*#{query}*",  # Simple wildcard-based search
              fields: [ "content" ]
            }
          },
          filter: {
            term: { chat_id: chat_id }
          }
        }
      }
    ).records.to_json(except: [ :id, :chat_id ])
  end

  private

def self.sanitize_query(query)
  cleaned_query = query.to_s.strip.gsub(/\s+/, " ")
  cleaned_query.gsub(/([+\-=&|><!(){}\[\]^"~*?:\\\/])/, '\\\\\1')
end
end
