class NilClass
  def blank?
    true
  end
end

class String
  def blank?
    self.size == 0
  end
end

["", "Foo", nil, "Bar"].each do |element|
  print element unless element.blank?
end
