module JobCheckout
  class FileParser
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def inputs
      return [] unless file_present? || File.read(name)
      return [] unless File.read(name)
      parse
    end

    private

    def file_present?
      return false unless name
      File.file?(name)
    end

    def parse
      customers = []
      customer = {}
      IO.foreach(name) do |line|
        line = line.strip
        if line.strip.empty?
          customers << customer
          customer = {}
        else
          key, value = line.strip.split(':').collect(&:strip)
          customer[key.downcase.to_sym] = value
        end
      end
      customers << customer
      customers.reject(&:empty?)
    end
  end
end
