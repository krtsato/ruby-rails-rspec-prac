# frozen_string_literal: true

module Staff
  class SessionsController < Base
    def new
      if current_staff_member
        redirect_to :staff_root
      else
        @form = LoginForm.new
        render action: 'new'
      end
    end

    def create
      @form = LoginForm.new(params[:staff_login_form])
      if @form.email.present?
        staff_member = StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
      end

      if staff_member
        session[:staff_member_id] = staff_member.id
        redirect_to :staff_root
      else
        render action: 'new'
      end
    end

    def destroy
      session.delete(:staff_member_id)
      redirect_to :staff_root
    end
  end
end
