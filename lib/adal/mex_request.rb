#-------------------------------------------------------------------------------
# Copyright (c) 2015 Micorosft Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-------------------------------------------------------------------------------

require_relative './mex_response'
require_relative './util'

require 'httpclient'
require 'uri'

module ADAL
  # A request to a Metadata Exchange endpoint of an ADFS server. Used to obtain
  # the WSTrust endpoint for username and password authentication of federated
  # users.
  class MexRequest
    include Util

    ##
    # Constructs a MexRequest object for a specific URL endpoint.
    #
    # @param String|URI endpoint
    #   The Metadata Exchange endpoint.
    def initialize(endpoint)
      @endpoint = URI.parse(endpoint.to_s)
    end

    # @return MexResponse
    def execute
      response = HTTPClient.get(@endpoint, header: {'Content-Type' => 'application/soap+xml'})
      MexResponse.parse(response.body)
    end
  end
end
