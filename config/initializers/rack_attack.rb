# frozen_string_literal: true

Rack::Attack.throttle('requests by ip', limit: 30, period: 60, &:ip)
