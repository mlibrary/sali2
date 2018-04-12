# Requesting and scheduling an Instructional Session is a multi-step process.
# The process starts when someone creates a request for a session with an
# initial state of "draft".  More editing may occur, but the next step is
# to submit it for scheduling, which changes its state to "requested".
# More changes may be made, including the following:
#
#   - Reviewing the request and filling in details
#   - Setting start-time and end-time
#   - Adding instructor(s)
#   - Adding a room (or marking not needed)
#   - Adding an evaluation (or marking not needed)
#   - Adding a registration option (or marking not needed)
#
# Once the details are set, scheduling ends and the session is considered
# "scheduled".  The state of the request is changed to "scheduled" and a
# Session is created with all relevant information from the Session
# Request.  Later, details about the session might change, but there's
# no need to update the Session Request once it is scheduled.

class SessionRequest
  attr_accessor :requested_by

  def initialize(attribute_hash = {})
    self.requested_by = attribute_hash[:requested_by]
  end
end