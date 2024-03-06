import flag
import os

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('vlang-forth')
	fp.version('0.0.1')
	fp.description('Forth like interpreter')
	fp.usage_example('-c file.fs')
	fp.usage_example('-i file.fs')
	fp.skip_executable()

	compile := fp.bool('compile', `c`, false, 'compile the given file')
	interpret := fp.bool('interpret', `i`, false, 'run the interpreter on the given file')

	// We are expecting the file name as the remaining arguments
	rp := fp.remaining_parameters()

	file := rp[0]
	if !os.is_readable(file) {
		println('${file} is not readable')
		exit(1)
	}

	prog_str := os.read_file(file)!
	println('==== PROG START')
	print(prog_str)
	println('==== PROG END')

	prog := get_ops(prog_str)

	if interpret {
		prog.interpret()
	} else {
		println('INFO: interpretation skipped')
	}

	if compile {
		exe_name := file.all_before_last('.')
		if exe_name == file {
			// Append .exe because we don't want to erase the original file :)
			prog.compile(exe_name + '.exe')
		} else {
			prog.compile(exe_name)
		}
	} else {
		println('INFO: compilation skipped')
	}
}
