module Middlewares
  class CustomRequestLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      req = ActionDispatch::Request.new(env)

      started_at = Time.now
      Rails.logger.info('='*100)
      Rails.logger.info("<<< Started: #{started_at.to_s(:db)} >>>")
      Rails.logger.info("<<< Method: #{req.method}, IP: #{req.ip}, Path: #{req.path}, Params: #{req.parameters} >>>")


      @status, @headers, @response = @app.call(req.env)

      ended_at = Time.now
      Rails.logger.info("<<< Ended: #{ended_at.to_s(:db)} >>>")
      Rails.logger.info('='*100)

      [@status, @headers, @response]
    end
  end
end