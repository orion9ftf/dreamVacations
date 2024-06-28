class CsvImportService
  def initialize(file)
    @file = file
    @count = 0
  end

  def import_csv
    CSV.foreach(@file.path, headers: true) do |row|
      Person.create! row.to_hash
      @count += 1
    end
    @count
  end
end
