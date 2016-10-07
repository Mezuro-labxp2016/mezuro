class IntervalValidator < ActiveModel::Validator
  def validate(record)
    if record.beginning >= record.end
      record.errors['end'] << 'The End value should be greater than the Beginning value.'
    end
  end
end
