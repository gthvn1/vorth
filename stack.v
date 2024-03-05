// We manage the stack as a double linked list with a head
struct Stack {
mut:
	head ?&Elmt
}

struct Elmt {
mut:
	next ?&Elmt
	prev ?&Elmt
	v    u8
}

// As we return an address Stack is heap allocated
// Return an empty stack
fn alloc_stack() &Stack {
	return &Stack{none}
}

fn (mut s Stack) push(v u8) {
	// If there is already an element the new one will become the new head
	if mut old_head := s.head {
		new_head := &Elmt{
			next: none
			prev: old_head
			v: v
		}
		old_head.next = new_head
		s.head = new_head
	} else {
		// List is empty
		new_head := &Elmt{none, none, v}
		s.head = new_head
	}
}

fn (mut s Stack) pop() ?u8 {
	return if mut h := s.head {
		v := h.v
		s.head = h.prev
		if mut new_head := s.head {
			new_head.next = none
		}
		v
	} else {
		none
	}
}
