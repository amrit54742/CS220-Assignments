
// Amrit kumar --190122
// Yash Gupta ---190997


.data

arr: .word 7, 3, 8, 4, 2
n: .word 5

.text

main:
    la $s0, arr                         # $s0 = arr
    lw $s1, n                           # $s1 = n

    li $s2, 0                           # $s2 = i (counter for outer_loop)

outer_loop:
    addi $t0, $s1, -1                   # $t0 = n - 1
    bge $s2, $t0, end          # if i >= n - 1, end outer_loop

    li $s3, 0                           # $s3 = j (counter for inner_loop)
    li $s5, 0                           # $s5 = j * 4

inner_loop:
    addi $t1, $s1, -1                   # $t1 = n - 1
    bge $s3, $t1, update_outer_loop    # if j >= n - 1, end inner_loop

    add $t2, $s0, $s5                   # $t2 = arr + j
    lw $t3, 0($t2)                      # $t3 = arr[j]
    lw $t4, 4($t2)                      # $t4 = arr[j + 1]

    ble $t3, $t4, update_inner_loop    # if arr[j] <= arr[j + 1], skip swap

swap:
    sw $t4, 0($t2)                      # arr[j] = arr[j + 1]
    sw $t3, 4($t2)                      # arr[j + 1] = arr[j]

update_inner_loop:
    addi $s3, $s3, 1                    # j++
    addi $s5, $s5, 4                    # j * 4
    j inner_loop

update_outer_loop:
    addi $s2, $s2, 1                    # i++
    j outer_loop

end:
    li $v0, 10                          # end program
    syscall
