class JajahanData
  @@data = {}
  @params = [
    type: 'Select data type from types',
    area: 'If data type is postcode, select area from postcode_areas',
  ].freeze
  @types = [
    'bank',
    'country',
    'district',
    'dun',
    'education-level',
    'gender',
    'state',
    'subdistrict',
    'postcode',
    'parliament'
  ].freeze
  @postcode_areas = [
    'johor',
    'kedah',
    'kelantan',
    'melaka',
    'negeri-sembilan',
    'pahang',
    'perak',
    'perlis',
    'pulau-pinang',
    'sabah',
    'sarawak',
    'selangor',
    'terengganu',
    'wp-kuala-lumpur',
    'wp-labuan',
    'wp-putrajaya'
  ].freeze

  def self.options
    {
      params: @params,
      types: @types,
      postcode_areas: @postcode_areas,
      data_source: 'https://github.com/lomotech/jajahan'
    }
  end

  def self.fetch_data params
    return @@data[params[:type]] if @@data[params[:type]]
    if @types.include? params[:type]
      data = File.read("#{Rails.root}/db/#{params[:type]}.php") unless params[:type] == 'postcode'
      if params[:type] == 'postcode' && @postcode_areas.include?(params[:area])
        data = File.read("#{Rails.root}/db/postcode/#{params[:area]}.php")
      end

      data = data.scan(/\$[\s\S]*?\];/).last
      data = data.gsub(/\/\/.*/, '') .gsub(/\/\*[\s\S]+?\*\//, '') # remove comments

      data = eval data
      data = data.map { |e| e = e.first } # convert array->arrays->object to array->objects

      @@data[params[:type]] = data
      return @@data[params[:type]]
    end
  end
end