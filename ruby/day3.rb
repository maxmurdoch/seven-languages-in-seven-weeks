module ActsAsCsv

  # Object#def creates a method definition
  # Module#included is a callback executed when the receiver
  # is included in another module or class. Here it’s called
  # when `ActsAsCsv` is included into the Csv class.
  def self.included(base)

    # Object#extend extends the receiving object with the instance
    # variables of all modules passed in as params.
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv

      # Module#include invokes Module#append_features on each
      # parameter in reverse order.
      include InstanceMethods
    end
  end

  module InstanceMethods
    #
    # attr_accessor set instance variables and provides read
    # and write access to them.
    attr_accessor :headers, :csv_contents

    def read
      
      # The instance variable `@csv_contents` is assigned to an empty array.
      @csv_contents = []

      # `filename` is assigned to the instance object’s class name turned into
      # a lowercase string and prepended onto '.txt'.
      filename = self.class.to_s.downcase + '.txt'

      # `file` is assigned to a new instance of the `File` class with the 
      # name assigned to `filename`.
      file = File.new filename

      # The `@headers` instance variable is set to an array of strings (#split)
      # from the first line of the `file` (#gets) with ‘\r’ and ‘\n’ removed (#chomp)
      @headers = file.gets.chomp.split(', ')

      # Each line of the file is enumerated over. Each row has ‘\r’ and ‘\n’ removed
      # and is turned into an array of strings separated by a comma followed by a space.
      # This array is then appended to the `@csv_contents` instance variable.
      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end
    
    # Class#initialize is a method called when the #new method is called on a class.
    def initialize
      read
    end

  end
end

class Csv

  # Includes the ActsAsCsv module
  include ActsAsCsv

  # Calls the `acts_as_csv` method, extended as a result of including the ActsAsCsv module,
  # which then includes the `InstanceMethods` module.
  acts_as_csv

  class CsvRow
    def initialize headers, rows
      @headers = headers
      @rows = rows
    end

    # `method_missing` is called when an Object receives a message it can’t handle.
    # Here it is overridden to enable dynamic behaviour.
    def method_missing name

      # The index variable is set to the return value of passing the stringified
      # `method_missing` parameter to the #index method of the @headers array.
      index = @headers.index name.to_s

      # The method then returns the row element at the same index as the header element.
      @rows[index]
    end
  end

  # The `each` method takes a block as a paremeter, loops through each row of the @csv_contents
  # variable, calls block and instantiates the CsvRow class with the @headers array and 
  # the row being iterated.
  def each &block
    @csv_contents.each do |row|
      block.call CsvRow.new @headers, row
    end
  end

end

csv = Csv.new
csv.each {|row| puts row.two}
