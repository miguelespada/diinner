class TimePickerInput < DatePickerInput
  private

  def display_pattern
    I18n.t('timepicker.dformat', default: '%R')
  end

  def picker_pattern
    I18n.t('timepicker.pformat', default: 'HH:mm')
  end

  def date_options
    date_options_base
  end

  def input_button
    template.content_tag :span, class: 'input-group-btn' do
      template.content_tag :button, class: 'btn btn-default', type: 'button' do
        template.content_tag :span, '', class: 'glyphicon glyphicon-time'
      end
    end
  end
end
