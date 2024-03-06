//;; https://jameshfisher.com/2018/03/10/linux-assembly-hello-world/
import log
import os

fn (tokens []Token) compile(fname string) {
	mut code := ''

	// First we need to generate the assembly file
	code += '    ;; Code of dump has been generated from examples/dump.c using
    ;; https://godbolt.org with -03 optimizations.
    ;; Few small fixes were needed:
    ;;   - remove PTR
    ;;   - s/movabs/mov
    ;;   - replace the jump to an @ by jump to .dump_loop
    ;;   - replace the call to write by a syscall
    BITS 64
    global _start
    section .text

    dump:
        sub    rsp,0x28
        mov    ecx,0x1e
        mov    r9,0xcccccccccccccccd
        mov    BYTE [rsp+0x1f],0xa
        nop    DWORD [rax+rax*1+0x0]
    .dump_loop:
        mov    rax,rdi
        mov    r8d,ecx
        mul    r9
        mov    rax,rdi
        shr    rdx,0x3
        lea    rsi,[rdx+rdx*4]
        add    rsi,rsi
        sub    rax,rsi
        mov    esi,ecx
        sub    ecx,0x1
        add    eax,0x30
        mov    BYTE [rsp+r8*1],al
        mov    rax,rdi
        mov    rdi,rdx
        cmp    rax,0x9
        ja     .dump_loop
        mov    edx,0x20
        mov    edi,0x1
        sub    edx,esi
        add    rsi,rsp
        mov    eax,0x1
        syscall
        add    rsp,0x28
        ret\n\n'

	code += '    _start:\n'

	for tok in tokens {
		match tok {
			Add {
				code += '        ;; ADD generated
        pop rax
        pop rbx
        add rbx, rax
        push rbx\n'
			}
			Sub {
				code += '        ;; SUB generated
        pop rax
        pop rbx
        sub rbx, rax
        push rbx\n'
			}
			Dot {
				code += '        ;; DOT generated
        pop rdi
        call dump\n'
			}
			Push {
				code += '        ;; PUSH generated
        push ${tok.v}\n'
			}
		}
	}

	code += '
        ;; exit(EXIT_SUCESS)
        mov rax, 60
        mov rdi, 0
        syscall\n'

	// Then we can compile it
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
