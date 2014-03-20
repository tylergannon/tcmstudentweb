module ETL::Control::ContextFieldTransformationDsl
  def add_metadata(klass, import)
    before_write { |row|
      new_record = klass.new row.slice(*klass::IMPORT_ATTRIBUTES)
      new_record.import = import
      
      campaign_id = import.campaign_id || row[:campaign_id]
      
      new_record.campaign_detail = CampaignDetail.find_by campaign_id: campaign_id,
        link_position: row[:link_position]

      new_record.campaign_detail ||= CampaignDetail.find_or_create campaign_id: campaign_id,
        link_position: 'Other'
      
      new_record.import_attributes
    }
  end

  def foreign_key_projection(class_name, params)
    fk, pk = params.first
    source_field, dest_field = [fk, pk].map{|t| "#{class_name}_#{t}".to_sym}
    klass = class_name.to_s.classify.constantize
    finder = "find_by_#{fk}".to_sym
    objects = klass.all
    # resolver = ActiveRecordResolver.new klass, finder

    default = params[:default_value]

    transform source_field do |name, value, row|
      object = objects.select{|t| t.send(fk) == row[source_field]}.first
      row[dest_field] = object ? object.id : default
      value
    end
  end

  def split_projection(field, options)
    # options[:field] = field
    transform field, :split_field, {
      on: options[:on],
      join: options[:join_ranges_with],
      to: options.except(:on, :join_ranges_with)
    }
  end
  
  #  Look up the Segment ID based on Name.
  def project_segment_name_to_id
    transform :segment_name do |name, value, row|
      row[:segment_id] = case value
      when "NMCTRLNS"      then Segment.non_member_new_id
      when "MCTRLNS"       then Segment.member_new_id
      when /NMCTRL[^e]*\Z/ then Segment.non_member.id
      when /MCTRL[^e]*\Z/  then Segment.member.id
      when /NMTEST[^e]*\Z/ then Segment.non_member_test.id
      when /MTEST[^e]*\Z/  then Segment.member_test.id
      when /\AM\Z/i then Segment.member_id
      when /\ANM\Z/i then Segment.non_member_id
      else nil
      end
      
      value
    end
  end
  
  
  def project_mailing_type_name_to_id
    foreign_key_projection :mailing_type,
                           :abbreviation => :id,
                           default_value: nil
  end
  
  #  This is where KEYWORD is parsed and put into its destination columns.
  #   If keyword format will change, come here to reflect that in the code.
  #   Zero-based indexes.
  def project_keyword_as_tracking_code
    split_projection    :keyword,
                        on:               '-',
                        mailing_type_abbreviation:    1,
                        segment_name:     2,
                        campaign_date:     3,
                        link_position:         4,
                        content_area:     5..-1,
                        join_ranges_with: '-'
                        
    #  Come here if Campaign Date format needs to change.
    where campaign_date: /\A\d{6}\Z/ do
      reformat_date       :campaign_date, '%m%d%y' => '%Y-%m-%d'
    end
  end


  # Row transform DSL

  def set(mappings)
    mappings.each do |field, value|
      transform field do |name, v, row|
        value
      end
    end
  end
  
  # Field transformation DSL
  def set_campaign_id_from_campaign_date
    transform :campaign_date do |name, value, row|
      campaign = Campaign.find_or_create campaign_date: value, mailing_type_id: row[:mailing_type_id]
      row[:campaign_id] = campaign.id
      value
    end
  end

  def reformat_date(field, transformation)
    input_format, output_format = transformation.first

    transform field do |name, value, row|
      unless value.nil?
        begin
          date = Date.strptime(value, input_format)
        rescue Exception => e
          Rails.logger.error e.message + "\n" + e.backtrace.inspect
          Rails.logger.error row.inspect
          date = nil
        end
        
        unless date.nil?
          value = date.strftime output_format
        end
      end
      value
    end
  end

  def regexp_transform(field, expressions)
    transform field, :regexp, expressions
  end

  def trim_whitespace_from *fields
    fields.each do |field|
      transform field do |n, value, o|
        value.strip if value
      end
    end
  end
  
  
  def transform_link_positions
    regexp_transform    :link_position, 
                        /\A([A-Z0-9]{2,})[a-z]{1}\Z/  => '\1',        # Remove single trailing lowercase from uppercase word.
                        /GAMES.*/   => 'GAMES',
                        /MEM\d+.*/     => 'MEM',
                        /COMM.*/    => 'COMM',
                        /MORE.*/    => 'MORE',
                        /WEEK.*/    => 'WEEK',
                        /FT(\d)/    => 'F\1',     # Change FT3 -> F3
                        /GAME\Z/    => 'GAMES',   # 
                        /\AF(\d).+\Z/   => 'F\1'
  end
  
  def exclude_older_and_non_webletter_data(import)
    after_read do |row|
      campaign_date = nil
      webletter = false
      keyword = row[:keyword]

      if keyword =~ /\d{6}/
        campaign_date = keyword.match(/\d{6}/)[0]
        campaign_date = Date.strptime(campaign_date, '%m%d%y')

        reporting_date = import.report_end_date.to_date
        webletter = true if keyword =~ /wbltr/i
      end

      if (webletter == true) && campaign_date && (campaign_date + (6*7).days) > reporting_date
        row
      else
        nil
      end
    end
  end
end