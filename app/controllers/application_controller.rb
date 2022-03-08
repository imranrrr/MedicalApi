class ApplicationController < ActionController::API

	def render_success(data = {}, message = "")
        p "responding with #{data.inspect}"
        render :json => {
        success: true,
        data: data,
        status: 200,
        message: message
        }
    end

    def render_failure(errors)
        p "responding with #{errors.inspect}"
        render :json => {
            success: false,
            errors: errors,
            status: 200
        }
    end
end
