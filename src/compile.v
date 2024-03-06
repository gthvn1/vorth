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
        mov    rcx,rdi
        mov    r9,rdi
        mov    esi,0x1
        mov    BYTE [rsp+0x1f],0xa
        neg    rcx
        mov    r8,0x6666666666666667
        cmovs  rcx,rdi
        mov    edi,0x1e
        nop    WORD [rax+rax*1+0x0]
    .label1
        mov    rax,rcx
        mov    r10d,edi
        imul   r8
        mov    rax,rcx
        sar    rax,0x3f
        sar    rdx,0x2
        sub    rdx,rax
        lea    rax,[rdx+rdx*4]
        add    rax,rax
        sub    rcx,rax
        mov    eax,edi
        add    ecx,0x30
        lea    edi,[rax-0x1]
        mov    BYTE [rsp+r10*1],cl
        mov    rcx,rdx
        mov    edx,esi
        add    esi,0x1
        test   rcx,rcx
        jne    .label1
        test   r9,r9
        jns    .label2
        mov    eax,edi
        lea    esi,[rdx+0x2]
        mov    BYTE [rsp+rax*1],0x2d
        mov    eax,edi
    .label2
        mov    edx,esi
        mov    edi,0x1
        lea    rsi,[rsp+rax*1]
        mov    eax, 0x1
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
			Dot {
				code += '        ;; DOT generated
        pop rdi
        call dump\n'
			}
			False {
				code += '        ;; FALSE generated
        push ${tok.v}\n'
			}
			Push {
				code += '        ;; PUSH generated
        push ${tok.v}\n'
			}
			Sub {
				code += '        ;; SUB generated
        pop rax
        pop rbx
        sub rbx, rax
        push rbx\n'
			}
			True {
				code += '        ;; TRUE generated
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
