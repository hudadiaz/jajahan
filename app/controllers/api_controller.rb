class ApiController < ApplicationController
  PATH = "#{Rails.root}/vendor/jajahan/"
  POSTCODE_PATH = "#{Rails.root}/vendor/jajahan/postcode/"

  def index
    @links ||= file_links
    render json: @links
  end

  def show
    render json: read_file("#{PATH}#{params[:name]}.php")
  rescue Errno::ENOENT
    return head 404
  end

  def postcode
    render json: read_file("#{POSTCODE_PATH}#{params[:name]}.php")
  rescue Errno::ENOENT
    return head 404
  end

  private

  def files(path)
    php = Dir.glob(path).select do |file|
      file.match(/^.*\.(php|PHP)$/)
    end
  end

  def file_links
    links = {postcode: {}}
    files("#{PATH}*").map do |file|
      file_name = file.sub(PATH, '').sub('.php', '')
      links[file_name] = root_url + file_name
    end
    files("#{POSTCODE_PATH}**").map do |file|
      file_name = file.sub(POSTCODE_PATH, '').sub('.php', '')
      links[:postcode][file_name] = "#{root_url}postcode/#{file_name}"
    end
    links
  end

  def read_file(file_name)
    data = cache.read(file_name) || File.read(file_name)
    start = data.index('$')
    content = data[start..-1].gsub(/\/\*([\s\S]*?)\*\//, '')
                             .gsub(/\/\/([\s\S]*?)\n/, '')
    cache.write(file_name, content)
    return eval content
  end
end
