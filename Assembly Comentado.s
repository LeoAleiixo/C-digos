.data

mensagem1: .asciiz "Digite a primeira nota (0 a 10):\n"
mensagem2: .asciiz "Digite a segunda nota (0 a 10):\n"
aprovado:  .asciiz "Aprovado!\n"
reprovado: .asciiz "Reprovado!\n"

.text

      # empilhamento
main: addi $sp, $sp, -24 
      sw $s0, 0 ($sp)
      sw $s1, 4 ($sp)
      sw $s2, 8 ($sp)
      sw $a0, 12 ($sp)
      sw $a1, 16 ($sp)
      sw $ra, 20 ($sp)

      # Imprime mensagem1
      addi $v0,$zero, 4   
      la $a0, mensagem1
      syscall

      # Lê inteiro
      addi $v0,$zero,5
      syscall

      # Adiciona o valor de n1 no registrador $S0
      add $s0,$zero,$v0

      # Imprime mensagem2
      addi $v0,$zero,4
      la $a0, mensagem2
      syscall

      # Lê inteiro
      addi $v0,$zero,5
      syscall

      # Adiciona o valor de n2 no registrador $s1
      add $s1,$zero,$v0

      # Passagem de Parâmetros
      add $a0, $s0, $zero
      add $a1, $s1, $zero

      # Chamando função
      jal CalculaMedia

      # Adicionando o valor que retornou da função no $s2 
      add $s2,$zero,$v0

      # Entrando na condição de $s2 ser maior ou igual a 6
      sge $t0, $s2, 6
      beq $t0, $zero, else

      # Imprime a mensagem aprovado pro usuário se $s2 for maior ou igual a 6
      addi $v0,$zero,4
      la $a0, aprovado
      syscall

      # Pula pro fim
      j fim

      # Imprime a mensagem reprovado pro usuário se $s2 for menor do que 6
else: addi $v0,$zero, 4 #Mostra mensagem
      la $a0, reprovado
      syscall

      #desempilhamento
fim:  lw $ra, 20 ($sp)
      lw $a1, 16 ($sp)
      lw $a0, 12 ($sp)
      lw $s2, 8 ($sp)
      lw $s1, 4 ($sp)
      lw $s0, 0 ($sp)
      addi $sp, $sp, 24         
      jr $ra

              #empilhamento
CalculaMedia: addi $sp, $sp, -4
              sw $a0, 0 ($sp)
              sw $a1, 4 ($sp)

              #$t0 recebendo a soma dos 2 parametros
              add $t0, $a0, $a1 

              #$v0 recebendo a divisão da soma por 2
              div $v0, $t0, 2  

              #desempilhamento
              lw $a1, 4 ($sp)   
              lw $a0, 0 ($sp)
              addi $sp, $sp, 4
              jr $ra