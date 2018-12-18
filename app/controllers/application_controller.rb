class ApplicationController < ActionController::API
  def cache
    @cache ||= ActiveSupport::Cache::MemoryStore.new
  end
end
