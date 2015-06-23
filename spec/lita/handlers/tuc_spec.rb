require 'spec_helper'

describe Lita::Handlers::Tuc, lita_handler: true do
  describe "#test" do
    it "Respond with balance" do
      send_command("tuc 00758888")
      expect(replies.last).to match(/C\$ \d{1,}.\d{1,}/)
    end
  end
end
