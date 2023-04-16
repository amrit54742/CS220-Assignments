.data

arr: .word 7, 3, 8, 4, 2
n: .word 5

.text

main:
    la $s0, arr                         # $s0 = arr
    # addi $s0, $0, arr
    001000 00000 10000 arr ##
    lw $s1, n                           # $s1 = n
    100011 n 10001 offset ##

    li $s2, 0                           # $s2 = i (counter for outer_loop)
    # addi $s2, $0, 0
    001000 00000 10010 0000000000000000

outer_loop:
    addi $t0, $s1, -1                   # $t0 = n - 1
    001000 10001 01000 -1 ##
    bgte $s2, $t0, end          # if i >= n - 1, end outer_loop
    ##

    li $s3, 0                           # $s3 = j (counter for inner_loop)
    # addi $s3, $0, 0
    001000 00000 10011 0000000000000000
    li $s5, 0                           # $s5 = j * 4
    # addi $s5, $0, 0
    001000 00000 10101 0000000000000000

inner_loop:
    addi $t1, $s1, -1                   # $t1 = n - 1
    001000 10001 01001 -1 ##
    bgte $s3, $t1, update_outer_loop    # if j >= n - 1, end inner_loop
    ##

    add $t2, $s0, $s5                   # $t2 = arr + j
    000000 10000 10101 10010 00000 100000
    lw $t3, 0($t2)                      # $t3 = arr[j]
    100011 01010 01011 0000000000000000
    lw $t4, 4($t2)                      # $t4 = arr[j + 1]
    100011 01010 01100 4 ##

    bleq $t3, $t4, update_inner_loop    # if arr[j] <= arr[j + 1], skip swap
    ##

swap:
    sw $t4, 0($t2)                      # arr[j] = arr[j + 1]
    101011 01010 01100 0000000000000000
    sw $t3, 4($t2)                      # arr[j + 1] = arr[j]
    101011 01010 01011 4 ##

update_inner_loop:
    addi $s3, $s3, 1                    # j++
    001000 10011 10011 0000000000000001
    addi $s5, $s5, 4                    # j * 4
    001000 10101 10101 0000000000000100
    j inner_loop
    ##

update_outer_loop:
    addi $s2, $s2, 1                    # i++
    001000 10010 10010 0000000000000001
    j outer_loop
    ##

end:
    li $v0, 10                          # end program
    # addi $v0, $0, 10
    001000 00000 00010 0000000000001010
    syscall
    ##
