class JajahanData
  @@data = {}
  @params = [
    type: 'Select data type from types',
    area: 'If data type is postcode, select area from postcode_areas',
  ].freeze
  @types = Dir.entries("#{Rails.root}/db/jajahan/")
            .select {|f| !File.directory? f}
            .map { |f| f.remove('.php') }.freeze
  @postcode_areas = Dir.entries("#{Rails.root}/db/jajahan/postcode")
                      .select {|f| !File.directory? f}
                      .map { |f| f.remove('.php') }.freeze

  def self.options
    {
      params: @params,
      types: @types,
      postcode_areas: @postcode_areas,
      data_source: 'https://github.com/lomotech/jajahan'
    }
  end

  def self.fetch_data params
    type = params[:type].downcase
    cache_name = "#{type}-#{params[:area]}"
    return @@data[cache_name] if @@data[cache_name]

    if @types.include? type
      data = File.read("#{Rails.root}/db/jajahan/#{type}.php") unless type == 'postcode'
      if type == 'postcode' && @postcode_areas.include?(params[:area])
        data = File.read("#{Rails.root}/db/jajahan/postcode/#{params[:area]}.php")
      end

      data = data.scan(/\$[\s\S]*?\];/).last
      data = data.gsub(/\/\/.*/, '') .gsub(/\/\*[\s\S]+?\*\//, '') # remove comments

      data = eval data
      data = data.map { |e| e = e.first } # convert array->arrays->object to array->objects

      p 'PARSED DATA'
      return @@data[cache_name] ||= data
    end
  rescue NoMethodError
    self.options
  end
end