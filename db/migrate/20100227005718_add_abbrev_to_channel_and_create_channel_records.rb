class AddAbbrevToChannelAndCreateChannelRecords < ActiveRecord::Migration
  def self.up
    add_column :channels, :abbreviation, :string
    add_column :channels, :commentary, :text

    Channel.all.each {|c| c.destroy}
    Channel.new(:name => 'Bladder', :abbreviation => 'UB').save
    Channel.new(:name => 'Lung', :abbreviation => 'Lu').save
    Channel.new(:name => 'Large Intestine', :abbreviation => 'LI').save
    Channel.new(:name => 'Stomach', :abbreviation => 'St').save
    Channel.new(:name => 'Spleen', :abbreviation => 'Sp').save
    Channel.new(:name => 'Heart', :abbreviation => 'Ht').save
    Channel.new(:name => 'Small Intestine', :abbreviation => 'SI').save
    Channel.new(:name => 'Bladder', :abbreviation => 'UB').save
    Channel.new(:name => 'Kidney', :abbreviation => 'Ki').save
    Channel.new(:name => 'Pericardium', :abbreviation => 'Pc').save
    Channel.new(:name => 'Triple Warmer', :abbreviation => 'SJ').save
    Channel.new(:name => 'Gallbladder', :abbreviation => 'GB').save
    Channel.new(:name => 'Liver', :abbreviation => 'Lv').save
    Channel.new(:name => 'Governing Vessel', :abbreviation => 'GV').save
    Channel.new(:name => 'Conception Vessel', :abbreviation => 'CV').save


  end

  def self.down
    remove_column :channels, :abbreviation
    remove_column :channels, :commentary

    Channel.all.each {|c| c.destroy}
  end
end
