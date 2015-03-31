class GenerateParseDataService
  def self.call(args = {})
    if_excel = Roo::Excelx.new(args[:if])
    fs_excel = Roo::Excelx.new(args[:fs])

    service = DataImportService.new
    service.import_if_data(if_excel)
    service.import_fs_data(fs_excel)

    service.datas
  end
end
