class ColorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\h{6}$/
      record.errors[attribute] << 'Color must be hexadecimal'
    end
  end
end
