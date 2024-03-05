fn (ops []Ops) run() {
	mut s := init_stack()

	for op in ops {
		match op {
			Add { // a b -- a + b
				b := s.pop() or {
					println('ERROR:Add: first pop failed')
					break
				}
				a := s.pop() or {
					println('ERROR:Add: second pop failed')
					break
				}
				s.push(a + b)
			}
			Sub { // a b -- a - b
				b := s.pop() or {
					println('ERROR:Sub: first pop failed')
					break
				}
				a := s.pop() or {
					println('ERROR:Sub: second pop failed')
					break
				}
				s.push(a - b)
			}
			Dot { // a --
				if v := s.pop() {
					println(v)
				} else {
					println('Empty stack...')
				}
			}
			Push { // -- a
				s.push(op.v)
			}
		}
	}
}
