import strutils
var f = open("data.txt")

type Instruction* = object
    op: int
    arg: int
    runCount: int
type CodePoint* = object 
    pc: int
    acc: int
type codeRun* = object
    queue: seq[CodePoint]
    success: bool
    
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

proc runCode(): codeRun =
    done = false
    var pc = 0
    var acc = 0
    var run: codeRun
    var queue: seq[CodePoint]
    var breakpoint = false
    var success = false
    while done == false:
        if(len(binary)-1 <= pc):
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
    run.queue = queue
    if pc == len(binary)-1:
        run.success = true
    return run
    
var run = runCode()
const position_offset = 2
echo "Part 1: PC: ", run.queue[len(run.queue) - position_offset].pc, " ACC: ", run.queue[len(run.queue) - position_offset].acc

proc resetRunCount() =
    for i in 0..len(binary)-1:
        binary[i].runCount = 0

for i in 0..(len(binary) - 1):
    resetRunCount()
    if binary[i].op == 1:
        binary[i].op = 2
        var data = runCode()
        if(data.success == true):
            echo "Part 2: PC: ", data.queue[len(data.queue) - 1].pc, " ACC: ", data.queue[len(data.queue) - 1].acc
            echo "Line: ", binary[i]
        binary[i].op = 1
    elif binary[i].op == 2:
        binary[i].op = 1
        var data = runCode()
        if(data.success == true):
            echo "Part 2: PC: ", data.queue[len(data.queue) - 1].pc, " ACC: ", data.queue[len(data.queue) - 1].acc
            echo "Line: ", i, " ", binary[i]
        binary[i].op = 2