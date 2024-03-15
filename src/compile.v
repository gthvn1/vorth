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
    .label1:
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
    .label2:
        mov    edx,esi
        mov    edi,0x1
        lea    rsi,[rsp+rax*1]
        mov    eax, 0x1
        syscall
        add    rsp,0x28
        ret\n\n'

	code += '    _start:\n'

	for i, tok in tokens {
		match tok {
			Add {
				code += '        ;; ADD generated
        pop rax
        pop rbx
        add rbx, rax
        push rbx\n'
			}
			Divmod {
				code += '        ;; Divmod generated
        xor rdx, rdx
        pop rbx
        pop rax
        div rbx  ; RAX: Quotient, RDX: Remainder
        push rax
        push rdx\n'
			}
			Do {
				code += '        ;; DO generated
        mov rax, ${true_value}
        pop rbx
        cmp rax, rbx
        jne .while_${tok.out}\n'
			}
			Done {
				code += '        ;; DONE generated
        jmp .while_${tok.begin}
        .while_${i}:\n'
			}
			Dot {
				code += '        ;; DOT generated
        pop rdi
        call dump\n'
			}
			Dup {
				code += '        ;; DUP generated
        pop rax
        push rax
        push rax\n'
			}
			Else {
				code += '        ;; ELSE generated
        jmp .if_${tok.out}
        .if_${i}:\n'
			}
			End {
				code += '        ;; END generated
        .if_${i}:\n'
			}
			Eq {
				code += '        ;; EQ generated
        mov rcx, ${false_value}
        mov rdx, ${true_value}
        pop rax
        pop rbx
        cmp rax, rbx
        cmove rcx, rdx ;; copies rdx to rcx if rax == rbx
        push rcx\n'
			}
			False {
				code += '        ;; FALSE generated
        push ${false_value}\n'
			}
			Gth {
				code += '        ;; GTH generated
        mov rcx, ${false_value}
        mov rdx, ${true_value}
        pop rbx
        pop rax
        cmp rax, rbx
        cmovg rcx, rdx ; if rax > rbx then rcx <- true
        push rcx\n'
			}
			If {
				code += '        ;; IF generated
        mov rax, ${true_value}
        pop rbx
        cmp rax, rbx
        jne .if_${tok.out}\n'
			}
			Load {
				code += '        ;; LOAD generated
        pop rax     ; first we pop the offset from mem
        shl rax, 3  ; working on quad so idx = idx * 8
        mov rbx, QWORD [rax + mem]
        push rbx\n'
			}
			Lth {
				code += '        ;; LTH generated
        mov rcx, ${false_value}
        mov rdx, ${true_value}
        pop rbx
        pop rax
        cmp rax, rbx
        cmovl rcx, rdx ; if rax < rbx then rcx <- true
        push rcx\n'
			}
			Mul {
				code += '        ;; MUL generated
        pop rax
        pop rbx
        mul rbx  ;; result is stored in rax
        push rax\n'
			}
			Not {
				code += '        ;; NOT generated
				mov rcx, ${false_value}
        mov rbx, ${true_value}
        pop rax
        cmp rax, rbx
        cmove rbx, rcx
        push rbx\n'
			}
			Neq {
				code += '        ;; NEQ is not implemented
        mov rcx, ${false_value}
        mov rdx, ${true_value}
        pop rax
        pop rbx
        cmp rax, rbx
        cmovne rcx, rdx ;; copies rdx to rcx if rax != rbx
        push rcx\n'
			}
			Push {
				code += '        ;; PUSH generated
        push ${tok.v}\n'
			}
			Store {
				code += '        ;; STORE generated
        pop rax  ; first we pop the offset from mem
        shl rax, 3  ; working on quad so idx = idx * 8
        pop rbx
        mov QWORD [rax + mem], rbx\n'
			}
			Sub {
				code += '        ;; SUB generated
        pop rax
        pop rbx
        sub rbx, rax
        push rbx\n'
			}
			Swap {
				code += '        ;; SWAP generated
        pop rbx
        pop rax
        push rbx
        push rax\n'
			}
			True {
				code += '        ;; TRUE generated
        push ${true_value}\n'
			}
			While {
				code += '        ;; WHILE generated
        .while_${i}:\n'
			}
		}
	}

	code += '
        ;; exit(EXIT_SUCESS)
        mov rax, 60
        mov rdi, 0
        syscall

    section .bss
	mem: resb 1024\n'

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
