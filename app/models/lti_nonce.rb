class LtiNonce < ActiveRecord::Base
  attr_accessible :nonce, :userId
end
