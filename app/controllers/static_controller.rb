class StaticController < ApplicationController

  def index
  end
  protected
    def self.permission
      'Static'
    end
end
