fn main() {
	mut s := alloc_stack()

	s.push(12)
	s.push(32)
	s.push(18)

	// Pop all elements
	for {
		v := s.pop() or { break }
		println('${v} has been poped')
	}
}
