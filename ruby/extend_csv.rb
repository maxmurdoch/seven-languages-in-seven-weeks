csv_content = <<END_CONTENT_BUFFER.strip.gsub( /^\t*/m, "" )

  id,name,age
  2,Max,23
  40,James,20
  10,Harry,18
  34,Robbie,17

END_CONTENT_BUFFER

csv_file = File.new('./data.csv', 'w')

csv_file.puts csv_content

csv_file.close
