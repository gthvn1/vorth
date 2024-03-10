import log
import os

struct Lexer {
	input string
mut:
	pos      int // current position in input
	read_pos int // current reading position (after current char)
	ch       u8  // the current char
	line     int
	column   int
	src      string
}

fn (mut l Lexer) tok_error(err string) ![]Token {
	return error(l.src + ':' + l.line.str() + ':' + l.column.str() + ':' + err)
}

// Move current position to the next one
fn (mut l Lexer) read_char() {
	if l.read_pos >= l.input.len {
		l.ch = 0
	} else {
		l.ch = l.input[l.read_pos]
		l.pos = l.read_pos
		l.read_pos++
		if l.ch == `\n` {
			l.line += 1
			l.column = 1
		} else {
			l.column += 1
		}
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

fn (mut l Lexer) skip_comments() {
	for {
		if l.ch == `\n` {
			break
		} else {
			l.read_char()
		}
	}
}

fn lookup(s string) ?Token {
	return match s {
		'divmod' { Token(Divmod{}) }
		'dup' { Token(Dup{}) }
		'false' { Token(False{}) }
		'mul' { Token(Mul{}) }
		'true' { Token(True{}) }
		'swap' { Token(Swap{}) }
		else { none }
	}
}

// Returns a list of token
fn tokenize(src_fname string) ![]Token {
	if !os.is_readable(src_fname) {
		return error('${src_fname} is not readable')
	}

	prog_str := os.read_file(src_fname)!
	log.debug('==== LOADING PROGRAM')
	for l in prog_str.split('\n') {
		log.debug(l)
	}
	log.debug('==== PROGRAM LOADED')

	mut toks := []Token{}
	mut lexer := Lexer{
		input: prog_str
		pos: 0
		read_pos: 1
		ch: prog_str[0]
		line: 1
		column: 1
		src: src_fname
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
			`*` {
				toks << Token(Mul{})
			}
			`.` {
				toks << Token(Dot{})
			}
			`=` {
				toks << Token(Eq{})
			}
			`<` {
				toks << Token(Lth{})
			}
			`>` {
				toks << Token(Gth{})
			}
			`/` {
				if lexer.peek_char() == `/` {
					// Skip comments ends on `\n` so don't continue because we need to
					// read the next caracter.
					lexer.skip_comments()
				} else {
					ident := lexer.read_identifier()
					return lexer.tok_error('cannot not found token for < ${ident} >')
				}
			}
			`!` {
				if lexer.peek_char() == `=` {
					lexer.read_char()
					toks << Token(Neq{})
					// No need to continue because we only read the = character
				} else {
					// Just log the identifier that starts with !
					return lexer.tok_error('only != is expected')
				}
			}
			else {
				if lexer.ch.is_digit() {
					i := lexer.read_integer()!
					toks << Token(Push{i})
					// after reading integer lexer is on the corrent next character so
					// restart the loop now
					continue
				}

				if lexer.ch.is_letter() {
					ident := lexer.read_identifier()
					if tok := lookup(ident) {
						toks << tok
					} else {
						return lexer.tok_error('unknown identifier < ${ident} >')
					}
					// after reading identifier lexer is on the corrent next character so
					// restart the loop now
					continue
				}

				ch_str := lexer.ch.ascii_str()
				return lexer.tok_error('cannot not found token for < ${ch_str} >')
			}
		}

		lexer.read_char()
	}

	return toks
}
