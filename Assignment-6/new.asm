.data
arr: .float 0.897, 0.565, 0.656, 0.1126, 0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656, 0.9989
buckets: .float -1.0 0.565 -1.0 0.1126 -1.0 0.3434 0.1126 0.554 0.3349 -1.0 0.3656 -1.0 0.897 -1.0 0.656 -1.0 0.665 -1.0 -1.0 -1.0 -1.0 0.678 -1.0 0.9989
bucket: .float 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 
zer: .float 0.0
newline: .asciiz "\n"

.text
.globl main

main:
    # we require these variables for computation
    li $s0, 12      
    li $s1, 2        
    la $s2, arr      
    la $s3, buckets 
    la $s4, bucket  
    la $s5, newline  

    li $t0, 0
loop5:
    bge $t0, $s1, done5   # for i >= n, so exit loop
    mul $t1, $t0, $s0    # calculate t1 = i * p
    add $t2, $t1, $s0    # calculate t2 = (i+1) * p

    # for insertion_sort(start, end) function

    move $a0, $t1   # start = &buckets[i*p]
    move $a1, $t2   # end = &buckets[(i+1)*p]
    jal insertion_sort

    addi $t0, $t0, 1    # i++
    j loop5

#########################

insertion_sort:
    addi $sp, $sp, -12          # allocate space on stack
    sw $ra, 8($sp)              # save return address
    sw $a0, 4($sp)              # save start index
    sw $a1, 0($sp)              # save end index

    addi $s6, $a0, 1            # i = start + 1
    move $s7, $a1               # end
loop:
    slt $t3, $s6, $s7           # check if i < end
    beq $t3, $zero, done        # if not, we're done

    move $t4, $s6               # j = i
inner_loop:
    bge $a0, $t4, end_inner     # check if start >= j
	sll $t4, $t4, 2
	add $t7, $s3, $t4
    lwc1 $f0, -4($t7)             # load buckets[j-1]   t2=f0
    lwc1 $f2, 0($t7)               # load buckets[j]      t3=f2
    c.le.s $f0, $f2             # check if buckets[j-1] <= buckets[j]
    bc1t end_inner              # jump to end_inner

    lwc1 $f4, -4($t7)           # temp = buckets[j-1]
    swc1 $f2, -4($t7)           # buckets[j-1] = buckets[j]
	swc1 $f4, ($t7)             # buckets[j] = temp
    addi $t4, $t4, -1            # j--
	j inner_loop
	
end_inner:
    addi $s6, $s6, 1            # i++
    j loop

done:
    lw $ra, 8($sp)              # restore return address
    lw $a0, 4($sp)              # restore start index
    lw $a1, 0($sp)              # restore end index
    addi $sp, $sp, 12           # deallocate stack space
    jr $ra                      # return

done5:
	li $t3, 0   #for next loop(bucket one) new i=0
    li $t4, 0    # new j=0
	j collect
#####################

	# Collect sorted numbers from buckets into bucket array
    li $t3, 0   #for next loop(bucket one) new i=0
    li $t4, 0    # new j=0
collect:
	mul $t5, $s0, $s1     # store n*p
    bge $t3, $t5, print   # for check, i >= n*p, exit loop
    #mul $t5, $t3, $s0     calculate t5 = i * p
    #add $t6, $t5, $s3     calculate t6 = &buckets[i*p]
	move $t6, $s3		  # s3=buckets
	sll $t0, $t3, 2       # t0 = t3*4
	add $t6, $t6, $t0     # for buckets[i]
	move $t7, $s4         # s4=bucket
	sll $t1, $t4, 2       # t1 = t4*4
	add $t7, $t7, $t1     #for bucket[j]
	li.s $f12, 0.0

	lwc1 $f0, 0($t6)
	c.lt.s $f0, $f12
	bc1f inner
	addi $t3, $t3, 1
inner:
  
	swc1 $f0, 0($t7)                      
    addi $t4, $t4, 1
	addi $t3, $t3, 1
	j collect 	

print: 

# we require these variables for printiong
    la $s0, buckets   # add of bucket[]
    li $s1, 24       # p
    la $s2, newline  # newline
	
	
# for Printing the sorted bucket array
    li $t0, 0
loop1:
    bge $t0, $s1, done1  
    lwc1 $f0, 0($s0)      
    li $v0, 2            
    mov.s $f12, $f0      
    syscall              
    la $a0, 0($s2)        
    li $v0, 4            
    syscall              
    addi $s0, $s0, 4     
    addi $t0, $t0, 1     
    j loop1

done1:
    li $v0, 10           # system call code for exit
    syscall              # exit program
