import strutils
var f = open("data.txt")

type Instruction* = object
    op: int
    arg: int
    runCount: int
type CodePoint* = object 
    pc: int
    acc: int

var binary: seq[Instruction]
var line: string
var done = false
while done != true:
    if readLine(f, line):
        var current_instr: Instruction
        if(line[0] == 'n'):
            current_instr.op = 2
        elif(line[0] == 'j'):
            current_instr.op = 1
        elif(line[0] == 'a'):
            current_instr.op = 0
        current_instr.runCount = 0
        #grab arg
        var op = line.split(" ")[1]
        current_instr.arg = parseInt(op)
        binary.add(current_instr)
    else:
        done = true

proc runCode(): seq[CodePoint] =
    done = false
    var pc = 0
    var acc = 0
    var queue: seq[CodePoint]
    var breakpoint = false
    while done == false:
        if(len(binary) < pc):
            done = true
            break
        #check for loop
        if(binary[pc].runCount >= 1):
            done = true 
            breakpoint = true
            break
        binary[pc].runCount = binary[pc].runCount + 1
        ##run loops
        #acc
        if(binary[pc].op == 0):
            acc = acc + binary[pc].arg
            pc = pc + 1
        #jmp
        elif(binary[pc].op == 1):
            pc = pc + binary[pc].arg
        #nop
        elif(binary[pc].op == 2):
            pc = pc + 1
        var point: CodePoint
        point.pc = pc
        point.acc = acc
        queue.add(point)
    return queue
    
var queue, breakpoint = runCode()

const position_offset = 2
echo "Part 1: PC: ", queue[len(queue) - position_offset].pc, " ACC: ", queue[len(queue) - position_offset].acc

for i in 1..200:
    echo "Previous instruction: ", i, ": ", queue[len(queue)-i], " op:", binary[queue[len(queue) - i].pc].op, " arg: ", binary[queue[len(queue) - i].pc].arg
echo "Part 2: PC: ", queue[len(queue) - 1].pc, " ACC: ", queue[len(queue) - 1].acc