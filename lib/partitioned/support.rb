module Partitioned
  module Support
    module_function

    def rails_5_or_above?
      ActiveRecord::VERSION::MAJOR >= 5
    end

    def rails_5_2_or_above?
      ([ActiveRecord::VERSION::MAJOR, ActiveRecord::VERSION::MINOR] <=> [5, 2]) != -1
    end
  end
end
