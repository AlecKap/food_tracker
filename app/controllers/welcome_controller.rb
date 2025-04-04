class WelcomeController < ApplicationController
  def index
    @entry_log = EntryLog.new
  end
end
