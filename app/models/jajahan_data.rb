class JajahanData
  @instruction = 
  @params = ['type', 'area']
  @types = [ 'bank', 'country', 'district', 'dun', 'education-level', 'gender', 'state', 'subdistrict', 'postcode' ]
  @postcode_areas = [ 'johor', 'kedah', 'kelantan', 'melaka', 'negeri-sembilan', 'pahang', 'perak', 'perlis', 'pulau-pinang', 'sabah', 'sarawak', 'selangor', 'terengganu', 'wp-kuala-lumpur', 'wp-labuan', 'wp-putrajaya' ]

  def self.options
    {
      instruction: @instruction,
      params: @params,
      types: @types,
      postcode_areas: @postcode_areas
    }
  end

  def self.fetch_data params
    if @types.include? params[:type]
      data = File.read("#{Rails.root}/db/#{params[:type]}.php")
      start = data.index('$items')
      return eval data[start..-1]
      if params[:type] == 'postcode' && @postcode_areas.include?(params[:area])
        # get postcode data by area
      end
    end
  end
end