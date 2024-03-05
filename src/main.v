fn main() {
	// Now we need to go from string to operands:
	//	 12 30 + .  -> Push(12) Push(30) Add() Dot()
	prog_str := '12   30 + .'
	prog := get_ops(prog_str)
	prog.run()
}
