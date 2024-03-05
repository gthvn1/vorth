import os

fn main() {
	prog_str := os.read_file('./test1.fs')!
	println('==== PROG START')
	print(prog_str)
	println('==== PROG END')

	prog := get_ops(prog_str)
	prog.run()
}
