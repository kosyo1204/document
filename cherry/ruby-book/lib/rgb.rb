def to_hex(r, g, b)
	# '#' +
	# r.to_s(16).rjust(2, '0') +
	# g.to_s(16).rjust(2, '0') +
	# b.to_s(16).rjust(2, '0')

	[r, g, b].sum('#') do |n|
		n.to_s(16).rjust(2, '0')
	end

	# [r, g, b].sum('#') {|a| a.to_s(16).rjust(2, '0')}
end

def to_ints(hex)
	# r  = hex[1..2]
	# g  = hex[3..4]
	# b  = hex[5..6]
	# r, g, b = hex[1..2], hex[3..4], hex[5..6]
	# r, g, b = hex.scan(/\w\w/)

	# ints = []
	# [r,g,b].each do |s|
	# 	ints << s.hex
	# end
	# ints = [r, g, b].map { |s| s.hex}

	hex.scan(/\w\w/).map(&:hex)
end




