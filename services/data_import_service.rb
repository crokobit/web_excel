require 'roo'
require 'pry'
require 'axlsx'

class DataUnit
  attr_accessor :customer, :terms, :limit, :total, :current, :one_to_fifteen, :sixteen_to_thirty, :thirty_one_to_sixty, :over_sixty
end

class DataImportService
  attr_accessor :datas
  def initialize
    self.datas = []
  end

  def import_if_data(excel)
    excel.default_sheet = excel.sheets.first  
    first_low = excel.first_row
    last_row = excel.last_row
    for i in first_low..last_row
      data = parse_if_data(excel.row(i))
      datas << data if data
    end
  end

  def import_fs_data(excel)
    excel.default_sheet = excel.sheets.first
    first_low = excel.first_row
    last_row = excel.last_row
    for i in first_low..last_row
      data = parse_fs_data(excel.row(i))
      datas << data if data
    end
  end

  private

  def parse_if_data(data)
    return nil unless data[1]
    return nil if data[1] == 'Customer'
    obj = DataUnit.new

    obj.customer = data[1]
    obj.terms = data[3].delete(' day(s)').to_f
    obj.limit = data[4].delete('USD ').to_f
    obj.total = data[5]
    obj.current = data[6]
    obj.one_to_fifteen = data[7]
    obj.sixteen_to_thirty = data[8]
    obj.thirty_one_to_sixty = data[9]
    obj.over_sixty = data[10] + data[11]

    obj

  rescue
    nil
  end

  def parse_fs_data(data)
    return nil if data[9].nil? || data[0].nil?
    return nil if data[0] == 'TOTAL'
    obj = DataUnit.new

    obj.customer = data[0]
    obj.terms = data[8]
    obj.limit = data[6]
    obj.total = data[9]
    obj.current = data[11]
    obj.one_to_fifteen = data[12]
    obj.sixteen_to_thirty = data[15]
    obj.thirty_one_to_sixty = data[18]
    obj.over_sixty = data[19]

    obj
  end
end
