# frozen_string_literal: true

class CustomerFormPresenter < UserFormPresenter
  # 性別
  def gender_field_block
    markup(:div, class: 'radio-buttons') do |m|
      m << decorated_label(:gender, '性別')
      m << radio_button(:gender, 'male')
      m << label(:gender_male, '男性')
      m << radio_button(:gender, 'female')
      m << label(:gender_female, '女性')
    end
  end
end
