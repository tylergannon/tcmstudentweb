class CreateAcuPointRecords < ActiveRecord::Migration
  def self.create_channel(channel_id, rangeof_fixnum)
    puts "Creating Acu Points #{Channel.find(channel_id).name} #{rangeof_fixnum.to_s}"
    (rangeof_fixnum).map.each do |t|
      AcuPoint.create(:channel_id => channel_id, :ordinal => t).save(false)
    end
  end

  def self.up
    AcuPoint.all.each {|t| t.destroy}
    create_channel(1, (1..11))
    create_channel(2, (1..20))
    create_channel(3, (1..45))
    create_channel(4, (1..21))
    create_channel(5, (1..9))
    create_channel(6, (1..23))
    create_channel(7, (1..67))
    create_channel(8, (1..27))
    create_channel(9, (1..9))
    create_channel(10, (1..21))
    create_channel(11, (1..44))
    create_channel(12, (1..14))
    create_channel(13, (1..28))
    create_channel(14, (1..24))
  end

  def self.down
    AcuPoint.all.each {|t| t.destroy}
  end
end
