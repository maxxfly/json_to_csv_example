module Convert
  require 'csv'

  def self.to_csv(json)
    headers = []
    datas = []

    json.each do |e|
      a = normalize(e)
      headers += a.keys
      datas << a
    end

    headers.uniq!

    csv_string = CSV.generate write_headers: true do |csv|
      csv << headers

      datas.each do |data|
        row = []
        headers.each do |header|
          row << data[header]
        end

        csv << row
      end
    end

    csv_string
  end

  private
  def self.normalize(json)
    partial = {}
    json.each do |key, elt|
      if elt.is_a? Hash
        normalize(elt).each do |k,v|
          partial[key + '.' + k] = v
        end
      elsif elt.is_a? Array
        partial[key] = elt.join(',')
      else
        partial[key] = elt
      end
    end
    partial
  end

end
