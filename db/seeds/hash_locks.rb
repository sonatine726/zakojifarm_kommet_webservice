256.times do |i|
  h = HashLock.create!(table: 'tags', column: 'value', key: sprintf('%02x', i))
  pp h
end
