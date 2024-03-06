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

	rp := fp.remaining_parameters()
	if rp.len == 0 {
		println('We are expecting a file name as the remaining argument')
		exit(1)
	}

	src_fname := rp[0]
	if !os.is_readable(src_fname) {
		println('${src_fname} is not readable')
		exit(1)
	}

	prog_str := os.read_file(src_fname)!
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
		exe_fname := src_fname.all_before_last('.')
		if exe_fname == src_fname {
			// Append .exe because we don't want to erase the original file :)
			prog.compile(exe_fname + '.exe')
		} else {
			prog.compile(exe_fname)
		}
	} else {
		println('INFO: compilation skipped')
	}
}
