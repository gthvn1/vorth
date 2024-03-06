//;; https://jameshfisher.com/2018/03/10/linux-assembly-hello-world/
import log
import os

fn (ops []Ops) compile(fname string) {
	mut code := ''

	code += '
  global _start
  section .text
  _start:
    mov rax, 1        ; write(
    mov rdi, 1        ;   STDOUT_FILENO,
    mov rsi, msg      ;   "Hello, world!",
    mov rdx, msglen   ;   sizeof("Hello, world!")
    syscall           ; );
    mov rax, 60       ; exit(
    mov rdi, 0        ;   EXIT_SUCCESS
    syscall           ; );
  section .rodata
    msg: db "Helllo, world!", 10
    msglen: equ $ - msg\n'

	assembly := fname + '.s'
	obj := fname + '.o'

	os.write_file(assembly, code) or {
		log.error('failed to write file')
		exit(1)
	}

	nasm_cmd := 'nasm -f elf64 -o ' + obj + ' ' + assembly
	os.execute_or_panic(nasm_cmd)

	ld_cmd := 'ld -o ' + fname + ' ' + obj
	os.execute_or_panic(ld_cmd)

	// Cleanup: keep the assembly file for debugging purpose
	os.rm(obj) or { log.error('Failed to remove ${obj}') }
}
