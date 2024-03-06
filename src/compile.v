//;; https://jameshfisher.com/2018/03/10/linux-assembly-hello-world/
import os

fn (ops []Ops) compile(fname string) {
	mut code := ''

	code += 'global _start\n'
	code += 'section .text\n'
	code += '_start:\n'
	code += '  mov rax, 1        ; write(\n'
	code += '  mov rdi, 1        ;   STDOUT_FILENO,\n'
	code += '  mov rsi, msg      ;   "Hello, world!",\n'
	code += '  mov rdx, msglen   ;   sizeof("Hello, world!")\n'
	code += '  syscall           ; );\n'
	code += '  mov rax, 60       ; exit(\n'
	code += '  mov rdi, 0        ;   EXIT_SUCCESS\n'
	code += '  syscall           ; );\n'
	code += 'section .rodata\n'
	code += '  msg: db "Helllo, world!", 10\n'
	code += '  msglen: equ $ - msg\n'

	assembly := fname + '.s'
	obj := fname + '.o'

	os.write_file(assembly, code) or {
		println('failed to write file')
		exit(1)
	}

	nasm_cmd := 'nasm -f elf64 -o ' + obj + ' ' + assembly
	os.execute_or_panic(nasm_cmd)

	ld_cmd := 'ld -o ' + fname + ' ' + obj
	os.execute_or_panic(ld_cmd)

	// Cleanup: keep the assembly file for debugging purpose
	os.rm(obj) or { println('Failed to remove ${obj}') }
}
