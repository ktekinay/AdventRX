#tag Class
Protected Class Advent_2024_12_24
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
		Private Shared Function Calculate(v1 As Integer, op As String, v2 As Integer) As Integer
		  select case op
		  case "AND"
		    return v1 and v2
		  case "OR"
		    return v1 or v2
		  case "xor"
		    return v1 xor v2
		  case else
		    raise new RuntimeException
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var queue() as string
		  var wires as new Dictionary
		  var ready as new Dictionary
		  var pool as new Dictionary
		  var zs as new Set
		  
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  var initialWires() as string = sections( 0 ).Split( EndOfLine )
		  var gateData() as string =  sections( 1 ).Split( EndOfLine )
		  
		  for each wire as string in initialWires
		    var parts() as string = wire.Split( ": " )
		    wire = parts( 0 )
		    var value as integer = parts( 1 ).ToInteger
		    
		    queue.Add wire
		    wires.Value( wire ) = value
		  next
		  
		  for each gateString as string in gateData
		    var parts() as string = gateString.Split( " " )
		    var gate as new Gate
		    gate.In1 = parts( 0 )
		    gate.Op = parts( 1 )
		    gate.In2 = parts( 2 )
		    gate.Out = parts( 4 )
		    
		    Store( pool, gate.In1, gate, false )
		    Store( pool, gate.In2, gate, false )
		  next
		  
		  do
		    for queueIndex as integer = 0 to queue.LastIndex
		      var wire as string = queue( queueIndex )
		      
		      if wire.BeginsWith( "z" ) then
		        zs.Add wire
		        continue
		      end if
		      
		      if ready.HasKey( wire ) then
		        var gates() as Gate = ready.Value( wire )
		        
		        for gateIndex as integer = gates.LastIndex downto 0
		          var gate as Gate = gates( gateIndex )
		          
		          if not wires.HasKey( gate.In1 ) or not wires.HasKey( gate.In2 ) then
		            continue
		          end if
		          
		          var in1 as integer = wires.Value( gate.In1 )
		          var in2 as integer = wires.Value( gate.In2 )
		          
		          var out as integer = Calculate( in1, gate.Op, in2 )
		          
		          queue.Add gate.Out
		          wires.Value( gate.Out ) = out
		          
		          gates.RemoveAt gateIndex
		        next
		        
		        if gates.Count = 0 then
		          ready.Remove( wire )
		        end if
		      end if
		      
		      if pool.HasKey( wire ) then
		        var gates() as Gate = pool.Value( wire )
		        pool.Remove( wire )
		        
		        for each gate as Gate in gates
		          Store ready, wire, gate, true
		        next
		      end if
		    next
		    
		    if ready.Count <> 0 then
		      queue.RemoveAll
		      
		      for each k as variant in ready.Keys
		        queue.Add k
		      next
		    else
		      exit
		    end if
		  loop
		  
		  var bitMaker() as string
		  bitMaker.ResizeTo zs.Count - 1
		  
		  while zs.Count <> 0
		    var z as string = zs.Pop
		    var bitValue as integer = wires.Value( z )
		    var index as integer = z.Middle( 1 ).ToInteger
		    bitMaker( bitMaker.LastIndex - index ) = bitValue.ToString
		  wend
		  
		  var bitString as string = "&b" + String.FromArray( bitMaker, "" )
		  var bitValue as integer = bitString.ToInteger
		  
		  return bitValue : if( IsTest, 2024, 53190357879014 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  
		  
		  
		  return 0 : if( IsTest, 0, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Store(dict As Dictionary, key As String, gate As Gate, useOther As Boolean)
		  var gates() as Gate
		  
		  if useOther then
		    if gate.In1 = key then
		      key = gate.In2
		    else
		      key = gate.In1
		    end if
		  end if
		  
		  if dict.HasKey( key ) then
		    gates = dict.Value( key )
		  else
		    dict.Value( key ) = gates
		  end if
		  
		  gates.Add gate
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"x00: 1\nx01: 0\nx02: 1\nx03: 1\nx04: 0\ny00: 1\ny01: 1\ny02: 1\ny03: 1\ny04: 1\n\nntg XOR fgs -> mjb\ny02 OR x01 -> tnw\nkwq OR kpj -> z05\nx00 OR x03 -> fst\ntgd XOR rvg -> z01\nvdt OR tnw -> bfw\nbfw AND frj -> z10\nffh OR nrd -> bqk\ny00 AND y03 -> djm\ny03 OR y00 -> psh\nbqk OR frj -> z08\ntnw OR fst -> frj\ngnj AND tgd -> z11\nbfw XOR mjb -> z00\nx03 OR x00 -> vdt\ngnj AND wpb -> z02\nx04 AND y00 -> kjc\ndjm OR pbm -> qhw\nnrd AND vdt -> hwm\nkjc AND fst -> rvg\ny04 OR y02 -> fgs\ny01 AND x02 -> pbm\nntg OR kjc -> kwq\npsh XOR fgs -> tgd\nqhw XOR tgd -> z09\npbm OR djm -> kpj\nx03 XOR y03 -> ffh\nx00 XOR y04 -> ntg\nbfw OR bqk -> z06\nnrd XOR fgs -> wpb\nfrj XOR qhw -> z04\nbqk OR frj -> z07\ny03 OR x01 -> nrd\nhwm AND bqk -> z03\ntgd XOR rvg -> z12\ntnw OR pbm -> gnj", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
