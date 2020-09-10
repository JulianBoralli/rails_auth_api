module JamViolation
  class ChuckNorrisError < StandardError
    def message
      "Never use Chuck Norris name in vain!  ᕙ(▀̿̿Ĺ̯̿̿▀̿ ̿) ᕗ  "
    end
  end

  def jam_violation?
    username =  params[:username]
    raise JamViolation::ChuckNorrisError if username == "Chuck Norris" 
  end
end
