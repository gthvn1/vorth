import log

fn tokenize(s string) []Token {
	mut toks := []Token{}

	for word in s.split_any(' \n\t') {
		// Skip white spaces
		if word.is_blank() {
			continue
		}

		// Otherwise check if it is a known opcode
		if word.is_int() {
			toks << Token(Push{word.int()})
		} else if word.compare('+') == 0 {
			toks << Token(Add{})
		} else if word.compare('.') == 0 {
			toks << Token(Dot{})
		} else {
			log.warn('Cannot not found ops for <${word}>')
		}
	}

	return toks
}
