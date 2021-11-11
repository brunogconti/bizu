class ComparisonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index create destroy]

def index
  @comparisons = Comparison.all
end

end


end
