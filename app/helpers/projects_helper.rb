module ProjectsHelper
  def format_with_ext(current_format)
    ext = 
      case current_format
      when 'plain'
        '.txt'
      when 'markdown'
        '.md'
      else
        'unknown format'
      end

      "#{current_format} (#{ext})"
  end
end
