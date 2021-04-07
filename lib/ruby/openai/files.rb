module OpenAI
  class Files
    include HTTParty
    base_uri "https://api.openai.com"

    def initialize(access_token: nil)
      @access_token = access_token || ENV["OPENAI_ACCESS_TOKEN"]
    end

    def list(version: default_version)
      self.class.get(
        "/#{version}/files",
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        }
      )
    end

    def upload(version: default_version, parameters: {})
      self.class.post(
        "/#{version}/files",
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        },
        body: parameters.merge(file: File.open(parameters[:file]))
      )
    end

    def retrieve(version: default_version, id:)
      self.class.get(
        "/#{version}/files/#{id}",
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        }
      )
    end

    def delete(version: default_version, id:)
      self.class.delete(
        "/#{version}/files/#{id}",
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{@access_token}"
        }
      )
    end

    private

    def default_version
      "v1".freeze
    end
  end
end
