class RangeOverlappingValidator < ActiveModel::Validator
  def validate(record)
    record.metric_configuration.kalibro_ranges.each do |range|
      if range.id != record.id && overlaps?(range, record)
        record.errors[:beginning] << "There is already a #{record.class} within these boundaries! Please, choose another interval."
      end
    end
  end

  def overlaps?(range1, range2)
    return true if range_1_begins_inside_range_2(range1, range2)
    return true if range_1_ends_inside_range_2(range1, range2)
    return true if range_1_begins_and_ends_inside_range_2(range1, range2)
    return true if range_1_begins_and_ends_inside_range_2(range2, range1)
    false
  end

  private

  # Range 1 - |------| <>    |------|
  # Range 2 - |----|   <> |----|
  def range_1_begins_inside_range_2(range1, range2)
    range1.beginning >= range2.beginning && range1.beginning < range2.end
  end

  # Range 1 - |------|   <> |------|
  # Range 2 -   |------| <>   |----|
  def range_1_ends_inside_range_2(range1, range2)
    range1.end > range2.beginning && range1.end <= range2.end
  end

  # Range 1 -   |---|  <> |------|
  # Range 2 - |------| <> |------|
  def range_1_begins_and_ends_inside_range_2(range1, range2)
    range1.beginning >= range2.beginning && range1.end <= range2.end
  end
end
