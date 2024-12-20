#tag Class
Protected Class Advent_2024_12_17
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Sub Adv(operand As Integer, registers As ChronospacialRegisters)
		  Debug "adv"
		  
		  var co as integer = ComboOperand( operand, registers )
		  var raised as integer = 2^co
		  var value as integer = registers.A \ raised
		  
		  Debug "  O: " + operand.ToString + "->" + co.ToString + "->(2^co)->" + raised.ToString
		  Debug "  A: " + registers.A.ToString + "\co->" + value.ToString + " (" + value.ToOctal + ")"
		  
		  registers.A = value
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Bdv(operand As Integer, registers As ChronospacialRegisters)
		  Debug "bdv"
		  
		  var co as integer = ComboOperand( operand, registers )
		  var raised as integer = 2^co
		  var value as integer = registers.A \ raised
		  
		  Debug "  O: " + operand.ToString + "->" + co.ToString + "->(2^co)->" + raised.ToString
		  Debug "  A: " + registers.A.ToString
		  Debug "  B: A\co->" + value.ToString
		  
		  registers.B = value
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Bst(operand As Integer, registers As ChronospacialRegisters)
		  Debug "bst"
		  
		  var co as integer = ComboOperand( operand, registers )
		  var value as integer = co mod 8
		  
		  Debug "  O: " + operand.ToString + "->" + co.ToString
		  Debug "  B: co mod 8->" + value.ToString
		  
		  registers.B = value
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Bxc(operand As Integer, registers As ChronospacialRegisters)
		  #pragma unused operand
		  
		  Debug "bxc"
		  
		  var value as integer = registers.B xor registers.C
		  
		  Debug "  C: " + registers.C.ToString
		  Debug "  B: " + registers.B.ToString + " xor C->" + value.ToString
		  
		  registers.B = value
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Bxl(operand As Integer, registers As ChronospacialRegisters)
		  Debug "bxl"
		  
		  var value as integer = registers.B xor operand
		  
		  Debug "  O: " + operand.ToString
		  Debug "  B: " + registers.B.ToString + " xor O->" + value.ToString
		  
		  registers.B = value
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var registers as ChronospacialRegisters
		  var operands() as integer
		  
		  Parse input, operands, registers
		  
		  var instructions() as Instruction = Instructions
		  
		  var out as string
		  
		  if IsTest or false then
		    out = Solve( operands, registers, instructions )
		  else
		    var A as integer = registers.A
		    var builder() as string
		    var B as integer
		    
		    while A > 0
		      builder.Add Solve( A ).ToString
		      
		      A = A \ 8
		    wend
		    
		    out = String.FromArray( builder, "," )
		  end if
		  
		  return out : if( IsTest, "4,6,3,5,6,3,5,2,1,0", "4,3,2,6,4,5,3,2,4" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  if IsTest then
		    return ""
		  end if
		  
		  for i as integer = 1 to 1000
		    var x as integer =  Solve( i )
		    if x = 5 then
		      Print i.ToString + " " + i.ToOctal
		    end if
		  next
		  
		  return ""
		  
		  var registers as ChronospacialRegisters
		  var operands() as integer
		  
		  Parse input, operands, registers
		  
		  var translation as new Dictionary
		  var A as integer = -1
		  
		  while translation.KeyCount < 8
		    A = A + 1
		    
		    var b as integer = Solve( A )
		    if not translation.HasKey( b ) then
		      translation.Value( b ) = A
		    end if
		  wend
		  
		  operands = array( 3, 1, 1 )
		  A = 0
		  
		  for oIndex as integer = 0 to operands.LastIndex
		    var d as integer = operands( oIndex )
		    
		    var t as integer = translation.Value( d ).IntegerValue
		    Print "Want " + d.ToString + ", A = " + t.ToString
		    A = A + ( t * ( 8^oIndex ) )
		  next
		  
		  var result as integer = A
		  
		  'A = translation.Value( 2 ).IntegerValue + ( translation.Value( 3 ).IntegerValue * 8 )
		  
		  var builder() as string
		  var B as integer
		  var oIndex as integer = -1
		  
		  while A > 0
		    oIndex = oIndex + 1
		    Print "Looking for " + operands( oIndex ).ToString
		    var rm as integer = A mod 8
		    Print "A = " + A.ToString + ", A mod 8 = " + rm.ToString
		    Print "... should be " + translation.Value( operands( oIndex ) ).IntegerValue.ToString
		    
		    B = Solve( A )
		    builder.Add B.ToString
		    
		    A = A \ 8
		  wend
		  
		  var out as string = String.FromArray( builder, "," )
		  
		  if out <> registers.Operands then
		    Print registers.Operands
		    Print out
		    Print result.ToString
		  end if
		  
		  'var registers as ChronospacialRegisters
		  'var operands() as integer
		  '
		  'Parse input, operands, registers
		  '
		  'var instructions() as Instruction = Instructions
		  'var operandsString as string = registers.Operands
		  'var operandsStringBytes as integer = ( operandsString.Bytes + 1 ) \ 2
		  '
		  'var freshRegisters as new ChronospacialRegisters
		  'Clone( registers, freshRegisters )
		  'freshRegisters.Operands = registers.Operands
		  '
		  'var aValue as integer = if( IsTest, 1, 35184372088832 )
		  'var out as string
		  'var lastOut as string
		  '
		  'var inc as integer = 2
		  '
		  'do
		  'registers.A = aValue
		  '
		  ''out = Solve( operands, registers, instructions )
		  '
		  'var A as integer = registers.A
		  'var builder() as string
		  'var B as integer
		  '
		  'while A > 0
		  'B = ( (((A mod 8) xor 1) xor 5) xor (A \ 2^((A mod 8) xor 1)) ) mod 8
		  'builder.Add B.ToString
		  '
		  'A = A \ 8
		  'wend
		  '
		  'out = String.FromArray( builder, "," )
		  'var outBytes as integer = builder.Count
		  '
		  'if out = operandsString then
		  'exit
		  'elseif outBytes > operandsStringBytes then
		  'return "too long!"
		  'end if
		  '
		  ''Clone( freshRegisters, registers )
		  '
		  'if out = lastOut then
		  'inc = inc + 1
		  'end if
		  '
		  'lastOut = out
		  'aValue = aValue + inc
		  'loop 
		  '
		  'var result as integer = aValue
		  '
		  'do
		  'aValue = aValue - 1
		  'Clone( freshRegisters, registers )
		  'registers.A = aValue
		  '
		  'if Solve( operands, registers, instructions ) = out then
		  'result = aValue
		  'aValue = aValue - 1
		  'else
		  'exit
		  'end if
		  'loop
		  
		  // 88645131582296 is too low'
		  return result : if( IsTest, 117440, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Cdv(operand As Integer, registers As ChronospacialRegisters)
		  Debug "cdv"
		  
		  var co as integer = ComboOperand( operand, registers )
		  var raised as integer = 2^co
		  var value as integer = registers.A \ raised
		  
		  Debug "  O: " + operand.ToString + "->" + co.ToString + "->(2^co)->" + raised.ToString
		  Debug "  A: " + registers.A.ToString
		  Debug "  C: A\co->" + value.ToString
		  
		  registers.C = value
		  registers.NextInstruction = registers.NextInstruction + 2
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Clone(fromR As ChronospacialRegisters, toR As ChronospacialRegisters)
		  toR.A = fromR.A
		  toR.B = fromR.B
		  toR.C = fromR.C
		  
		  toR.NextInstruction = 0
		  
		  toR.Out.RemoveAll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ComboOperand(value As Integer, registers As ChronospacialRegisters) As Integer
		  select case value
		  case 0 to 3
		    return value
		    
		  case 4
		    return registers.A
		    
		  case 5
		    return registers.B
		    
		  case 6
		    return registers.C
		    
		  case else
		    raise new RuntimeException
		    
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Debug(msg As String)
		  #if true then
		    Print msg
		  #else
		    #pragma unused msg
		  #endif
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub Instruction(operand As Integer, registers As ChronospacialRegisters)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Shared Function Instructions() As Instruction()
		  var instructions( 7 ) as Instruction
		  
		  instructions( 0 ) = AddressOf Adv
		  instructions( 1 ) = AddressOf Bxl
		  instructions( 2 ) = AddressOf Bst
		  instructions( 3 ) = AddressOf Jnz
		  instructions( 4 ) = AddressOf Bxc
		  instructions( 5 ) = AddressOf Out
		  instructions( 6 ) = AddressOf Bdv
		  instructions( 7 ) = AddressOf Cdv
		  
		  return instructions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Jnz(operand As Integer, registers As ChronospacialRegisters)
		  Debug "jnx"
		  
		  if registers.A = 0 then
		    Debug "  noop"
		    registers.NextInstruction = registers.NextInstruction + 2
		    
		  else
		    Debug "  jump to " + operand.ToString
		    Debug "-----------------------"
		    
		    registers.NextInstruction = operand
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Out(operand As Integer, registers As ChronospacialRegisters)
		  Debug "OUT"
		  
		  var co as integer = ComboOperand( operand, registers )
		  var comod as integer = co mod 8
		  var outValue as string = comod.ToString
		  
		  Debug "  O: " + operand.ToString + "->" + co.ToString + "->co mod 8->" + outValue
		  
		  registers.Out.Add outValue
		  registers.NextInstruction = registers.NextInstruction + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parse(input As String, ByRef operands() As Integer, ByRef registers As ChronospacialRegisters)
		  registers = new ChronospacialRegisters
		  
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  var registerRows() as string = sections( 0 ).Split( EndOfLine )
		  
		  registers.A = registerRows( 0 ).NthField( ": ", 2 ).ToInteger
		  registers.B = registerRows( 1 ).NthField( ": ", 2 ).ToInteger
		  registers.C = registerRows( 2 ).NthField( ": ", 2 ).ToInteger
		  
		  var operandsString as string = sections( 1 ).NthField( ": ", 2 )
		  registers.Operands = operandsString
		  
		  operands = ToIntegerArray( operandsString.Split( "," ) )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Solve(operands() As Integer, registers As ChronospacialRegisters, instructions() As Instruction) As String
		  Debug "Solving..."
		  
		  Debug "  I: " + registers.Operands
		  Debug "  A: " + registers.A.ToString + " (" + registers.A.ToOctal + ")"
		  Debug "  B: " + registers.B.ToString
		  Debug "  C: " + registers.C.ToString
		  
		  while registers.NextInstruction < operands.LastIndex
		    var program as integer = operands( registers.NextInstruction )
		    var operand as integer = operands( registers.NextInstruction + 1 )
		    instructions( program ).Invoke( operand, registers )
		  wend
		  
		  Debug EndOfLine
		  
		  var out as string = String.FromArray( registers.Out, "," )
		  return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Solve(A As Integer) As Integer
		  'return ( (((A mod 8) xor 1) xor 5) xor (A \ 2^((A mod 8) xor 1)) ) mod 8
		  return ( ( (A mod 8) xor 4 ) xor (A \ 2^((A mod 8) xor 1)) ) mod 8
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Register A: 729\nRegister B: 0\nRegister C: 0\n\nProgram: 0\x2C1\x2C5\x2C4\x2C3\x2C0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"Register A: 2024\nRegister B: 0\nRegister C: 0\n\nProgram: 0\x2C3\x2C5\x2C4\x2C3\x2C0", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
