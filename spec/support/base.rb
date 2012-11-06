# -*- encoding : utf-8 -*-
module WallySupport
  module Helpers
    def parse(json)
      ActiveSupport::JSON.decode(json)
    end
  end
end


