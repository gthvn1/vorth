import log

fn get_ops(s string) []Ops {
	mut o := []Ops{}

	for word in s.split_any(' \n\t') {
		// Skip white spaces
		if word.is_blank() {
			continue
		}

		// Otherwise check if it is a known opcode
		if word.is_int() {
			// An item on the stack is an u8 so assert that for now
			assert word.int() < 256
			o << Ops(Push{u8(word.int())})
		} else if word.compare('+') == 0 {
			o << Ops(Add{})
		} else if word.compare('.') == 0 {
			o << Ops(Dot{})
		} else {
			log.warn('Cannot not found ops for <${word}>')
		}
	}

	return o
}