import log

struct Lexer {
	input string
mut:
	pos      int // current position in input
	read_pos int // current reading position (after current char)
	ch       u8  // the current char
}

// Move current position to the next one
fn (mut l Lexer) read_char() {
	if l.read_pos >= l.input.len {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_pos]
		l.pos = l.read_pos
		l.read_pos++
	}
}

// Returns the next character to be read without modifying the lexer
fn (l Lexer) peek_char() u8 {
	return if l.read_pos >= l.input.len {
		`\0`
	} else {
		l.input[l.read_pos]
	}
}

// Read the integer at the current position and update the lexer
fn (mut l Lexer) read_integer() !int {
	pos := l.pos // Keep current position
	for l.ch.is_digit() {
		l.read_char()
	}

	read_int := l.input[pos..l.pos]

	return if read_int.is_int() {
		l.input[pos..l.pos].int()
	} else {
		error('Failed to read integer')
	}
}

// Read identifier at the current position and update the lexer
fn (mut l Lexer) read_identifier() string {
	pos := l.pos // Keep current position
	for l.ch.is_letter() {
		l.read_char()
	}

	return l.input[pos..l.pos]
}

// Returns a list of token
fn tokenize(s string) ![]Token {
	mut toks := []Token{}
	mut lexer := Lexer{
		input: s
		pos: 0
		read_pos: 1
		ch: s[0]
	}

	for {
		// Skip whitespaces
		if lexer.ch.is_space() {
			lexer.read_char()
			continue
		}

		match lexer.ch {
			`\0` {
				break
			}
			`+` {
				toks << Token(Add{})
			}
			`-` {
				toks << Token(Sub{})
			}
			`.` {
				toks << Token(Dot{})
			}
			else {
				if lexer.ch.is_digit() {
					i := lexer.read_integer()!
					toks << Token(Push{i})
					continue
				}

				if lexer.ch.is_letter() {
					ident := lexer.read_identifier()
					log.warn('Found identifier < ${ident} > but it is not yet implemented')
					continue
				}

				ch_str := lexer.ch.ascii_str()
				log.warn('Cannot not found token for < ${ch_str} >')
			}
		}

		lexer.read_char()
	}

	return toks
}
