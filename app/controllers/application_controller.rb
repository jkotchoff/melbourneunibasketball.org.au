class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_page(title)
    @current_page = Page.find_by_title(title)
    render "pages/show"
  end

private
  def member_params
    params.require(:member).permit(
      :eligibility_clause, :eligibility_justification, :payment_method,
      :given_name, :family_name, :email, :postal_address,
      :gender, :date_of_birth, :phone_number_mobile, :phone_number_other,
      :new_member, :your_existing_mubc_singlet_numbers, :how_did_you_hear_about_the_club,
      :amount_paid, :payment_confirmed, :photo, :photo_cache, :payment_acknowledgement,
      :international_student, :availability, :photo,
      :card_number, :card_expiry_month, :card_expiry_year, :card_cvv,
      :stripe_customer_id,
      {
        photo: []
      }
    )
  end
end
