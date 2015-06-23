require 'lita'
require 'json'

module Lita
  module Handlers
    class Tuc < Handler
      URL = "http://tuc.apinic.org/v1/";

      route %r{^tuc (\d{8})$}i, :tuc, command: true, help: {
        'tuc 00000000' => 'Return balance from MPeso TUC Cards'
      }

      def tuc(response)
        query = response.matches[0][0]

        http_response = http.get(
          URL + query
        )

        data = MultiJson.load(http_response.body)

        if data['error']
          reason = data['error']['message'] || "unknown error"
          Lita.logger.warn(
            "Error: #{reason}"
          )
        else
          response.reply data['balance']
        end
      rescue => e
        Lita.logger.error("Tuc#balance raised #{e.class}: #{e.message}")
        response.reply "Tuc has turned off the internetz, #{e.class} is raising '#{e.message}'"
      end
    end

    Lita.register_handler(Tuc)
  end
end
