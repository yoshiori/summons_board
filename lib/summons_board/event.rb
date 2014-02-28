require 'active_support/core_ext'

class SummonsBoard::Event

  BASE_DATE = DateTime.new(2014, 2, 27, 0, 0, 0, DateTime.now.zone)
  TYPE_TABLE_COUNT = 5
  WEEKLY_EVENT = %w(コイン 無し オール系 グリン系 コマドラ系 リード系 バトルチケット)

  def initialize(uid: )
    @type = uid[-3].to_i % TYPE_TABLE_COUNT
  end

  def schedule(target: DateTime.now)
    start_time = target.beginning_of_day
    time_list = time_lists[time_type(target: target)]
    { weekly: WEEKLY_EVENT[target.wday],
      times: time_list.map { |hour| (start_time + hour.hour)...(start_time + hour.hour + 1.hour) } }
  end

  def active?(target: DateTime.now)
    schedule(target: target)[:times].any? { |active_time| active_time.cover? target }
  end

  private
  def time_lists
    @time_list ||= begin
                     time_list = []
                     TYPE_TABLE_COUNT.times do |i|
                       time_list << [8 + i, 13 + i, 18 + i]
                     end
                     time_list
                   end
  end

  def time_type(target: )
    @type + (target - BASE_DATE).to_i % TYPE_TABLE_COUNT
  end
end
