#tag Class
Protected Class Advent_2024_12_24
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Binary operations on wires through gates"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Crossed Wires"
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
		Private Shared Sub Backtrace(w As Wire)
		  if w.InGate is nil then
		    Print if( w.InGate isa object, "<- ", "!! " ) + w.Name
		  elseif w.Gates.Count = 0 then
		    Print "<- " + w.Name
		  end if
		  
		  if w.InGate isa object then
		    var g as Gate = w.InGate
		    
		    if g.InWires.Count = 0 then
		      Print "---"
		    else
		      Backtrace g.InWire1
		      Backtrace g.InWire2
		    end if
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Build(gateDataString As String) As Dictionary
		  var machine as new Dictionary
		  
		  var gateData() as string = gateDataString.Split( EndOfLine )
		  
		  for each gateString as string in gateData
		    var parts() as string = gateString.Split( " " )
		    
		    if parts( 0 ) = "x01" or parts( 2 ) = "x01" then
		      parts = parts
		    end if
		    
		    var inW1 as Wire = machine.Lookup( parts( 0 ), nil )
		    if inW1 is nil then
		      inW1 = new Wire
		      inW1.Name = parts( 0 )
		      machine.Value( inW1.Name ) = inW1
		    end if
		    
		    var inW2 as Wire = machine.Lookup( parts( 2 ), nil )
		    if inW2 is nil then
		      inW2 = new Wire
		      inW2.Name = parts( 2 )
		      machine.Value( inW2.Name ) = inW2
		    end if
		    
		    var outW as Wire = machine.Lookup( parts( 4 ), nil )
		    if outW is nil then
		      outW = new Wire
		      outW.Name = parts( 4 )
		      machine.Value( outW.Name ) = outW
		    end if
		    
		    var gate as new Gate
		    gate.InWires.Add inW1.MyWeakRef
		    gate.InWires.Add inW2.MyWeakRef
		    gate.Op = parts( 1 )
		    gate.OutWire = outW
		    
		    outw.InGate = gate
		    
		    inW1.Gates.Add gate
		    inW2.Gates.Add gate
		  next
		  
		  return machine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  var initialWires() as string = sections( 0 ).Split( EndOfLine )
		  
		  var machine as Dictionary = Build( sections( 1 ) )
		  
		  var zs() as Wire = GetWires( machine, "z" )
		  
		  for each wireName as string in initialWires
		    var parts() as string = wireName.Split( ": " )
		    var w as Wire = machine.Value( parts( 0 ) )
		    
		    var value as integer = parts( 1 ).ToInt64
		    w.Set value
		  next
		  
		  var bitValue as integer = ToBinary( zs )
		  
		  return bitValue : if( IsTest, 2024, 53190357879014 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  if IsTest then
		    return ""
		  end if
		  
		  var sections() as string = Normalize( input ).Split( EndOfLine + EndOfLine )
		  
		  var machine as Dictionary = Build( sections( 1 ) )
		  
		  var zs() as Wire = GetWires( machine, "z" )
		  var xs() as Wire = GetWires( machine, "x" )
		  var ys() as Wire = GetWires( machine, "y" )
		  var allWires() as Wire = GetWires( machine, "" )
		  
		  Designate xs, ys
		  for i as integer = 0 to zs.LastIndex
		    Print i.ToString + ": " + zs( i ).Designation
		  next
		  
		  return ""
		  
		  var resultSet as new Set
		  
		  var failIndexes() as integer
		  
		  var failGates as new Set
		  var successGates as new Set
		  
		  var v as integer = 0
		  do
		    var v1 as integer = 2^v
		    
		    Reset allWires
		    
		    if Test( xs, ys, zs, v1, 0 ) then
		      successGates = Trace(xs( v ), successGates )
		      
		    else
		      failIndexes.Add v
		      
		      failGates = Trace( xs( v ), failGates )
		      
		      'failIndexes.Add v
		      
		      'Print v
		      'var fixSet as Set = Fix( xs, ys, zs, v, allWires )
		      '
		      'if fixSet.Count = 0 then
		      'fixSet = fixSet
		      'end if
		      '
		      'resultSet = resultSet.Union( fixSet )
		    end if
		    
		    v = v + 1
		  loop until v > xs.LastIndex
		  
		  failGates = failGates - successGates
		  
		  
		  
		  
		  
		  var failNames() as string
		  for each g as Gate in failGates
		    failNames.Add g.OutWire.Name
		  next
		  
		  failNames.Sort
		  
		  var result as string = String.FromArray( failNames, "," )
		  
		  'var val as integer = 2^xs.Count - 1
		  'for each v in failIndexes
		  'val = val - ( 2^v )
		  'next
		  
		  'Reset allWires
		  'call Test( xs, ys, zs, val, 0 )
		  
		  return result : if( IsTest, 0, 0 ) 
		  // Not bbp,mfr,mqf,nrn,pwk,rbr,tjp,z23
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Designate(xs() As Wire, ys() As Wire)
		  var pq as new PriorityQueue_MTC
		  
		  for i as integer = 0 to xs.LastIndex
		    var w as Wire = xs( i )
		    
		    w.Designation = w.Name
		    pq.Add i * 10, w
		  next
		  
		  for each w as Wire in ys
		    w.Designation = w.Name
		  next
		  
		  while pq.Count <> 0
		    var priority as integer = pq.PeekPriority
		    
		    var w as Wire = pq.Pop
		    
		    for each g as Gate in w.Gates
		      if g.OutWire.Designation <> "" then
		        continue
		      end if
		      
		      if g.InWire1.Designation = "" or g.InWire2.Designation = "" then
		        pq.Add priority + 1, w
		        continue
		      end if
		      
		      var parts() as string = array( g.InWire1.Designation, g.InWire2.Designation )
		      parts.Sort AddressOf DesignationSorter
		      
		      g.OutWire.Designation = "(" + String.FromArray( parts, " " + g.Op + " " ) + "): " + g.OutWire.Name
		      pq.Add priority + 5, g.OutWire
		    next
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DesignationSorter(s1 As String, s2 As String) As Integer
		  if s1.Bytes < s2.Bytes then
		    return 1
		  elseif s1.Bytes > s2.Bytes then
		    return -1
		  else
		    return s1.Compare( s1 )
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ExtractWires(s As Set) As Set
		  var wireSet as new Set
		  
		  for each g As Gate in s.ToArray
		    wireSet.Add g.InWire1
		    wireSet.Add g.InWire2
		    wireSet.Add g.OutWire
		  next
		  
		  return wireSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Fix(xs() As Wire, ys() As Wire, zs() As Wire, index As Integer, allWires() As Wire) As Set
		  'var xw as Wire = xs( index )
		  'var yw as Wire = ys( index )
		  '
		  'var xGateSet as Set = Trace( xw )
		  'var yGateSet as Set = Trace( yw )
		  '
		  'var uniqueXGateSet as Set = xGateSet - yGateSet
		  'var uniqueYGateSet as Set = yGateSet - xGateSet
		  '
		  'var xGates() as variant = uniqueXGateSet.ToArray
		  'var yGates() as variant = uniqueYGateSet.ToArray
		  '
		  '
		  'for each xGate as Gate in xGates
		  'var xOut as Wire = xGate.OutWire
		  'if xOut is nil then
		  'continue
		  'end if
		  '
		  'for each yGate as Gate in yGates
		  'var yOut as Wire = yGate.OutWire
		  'if yOut is nil then
		  'continue
		  'end if
		  '
		  'xGate.OutWire = yOut
		  'yGate.OutWire = xOut
		  '
		  'Reset allWires
		  'if Test( xs, ys, xs, 2^index, 0 ) then
		  'var fixSet as new Set
		  'fixSet.Add xOut.Name
		  'fixSet.Add yOut.Name
		  '
		  'return fixSet
		  'end if
		  '
		  'xGate.OutWire = xOut
		  'yGate.OutWire = yOut
		  'next
		  'next
		  '
		  'return new Set
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetWires(machine As Dictionary, prefix As String) As Wire()
		  var zs() as Wire
		  
		  for each v as variant in machine.Keys
		    var vs as string = v.StringValue
		    
		    if vs.BeginsWith( prefix ) then
		      zs.Add machine.Value( v )
		    end if
		  next
		  
		  zs.Sort AddressOf WireSorter
		  
		  return zs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Reset(allWires() As Wire)
		  for each w as Wire in allWires
		    w.WasSet = false
		    w.Value = 0
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Test(xs() As Wire, ys() As Wire, zs() As Wire, v1 As UInt64, v2 As UInt64) As Boolean
		  var expected as integer = v1 + v2
		  
		  var b1() as string = v1.ToBinary( xs.Count ).Split( "" )
		  var b2() as string = v2.ToBinary( ys.Count ).Split( "" )
		  
		  
		  for i as integer = 0 to b1.LastIndex
		    xs( i ).Set b1( b1.LastIndex - i ).ToInteger
		    ys( i ).Set b2( b2.LastIndex - i ).ToInteger
		  next
		  
		  var actual as integer = ToBinary( zs )
		  
		  if actual <> expected then
		    Print v1.ToBinary( xs.Count ) + " + " + v2.ToBinary( ys.Count ) _
		    + " = " + expected.ToBinary( zs.Count ) + ", not " + actual.ToBinary( zs.Count )
		  end if
		  
		  return actual = expected
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToBinary(zs() As Wire) As Integer
		  var bitMaker() as string
		  bitMaker.ResizeTo zs.Count - 1
		  
		  for each w as Wire in zs
		    var z as string = w.Name
		    var index as integer = z.Middle( 1 ).ToInteger
		    var bitValue as integer = w.Value
		    bitMaker( bitMaker.LastIndex - index ) = bitValue.ToString
		  next
		  
		  var bitString as string = "&b" + String.FromArray( bitMaker, "" )
		  var bitValue as integer = bitString.ToInteger
		  
		  return bitValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Trace(w As Wire, s As Set = nil) As Set
		  if s is nil then
		    s = new Set
		  end if
		  
		  if w is nil then
		    return s
		  end if
		  
		  for each g as Gate in w.Gates
		    s.Add g
		    s = Trace( g.OutWire, s )
		  next
		  
		  return s
		  
		  
		  'var printer() as string
		  '
		  'for each g as Gate in failGates.ToArray
		  'var inNames() as string
		  'inNames.Add g.InWire1.Name
		  'inNames.Add g.InWire2.Name
		  'inNames.Sort
		  '
		  'printer.Add String.FromArray( inNames, " " + g.Op + " " ) + " -> " + g.OutWire.Name
		  'next
		  '
		  'printer.Sort
		  'Print String.FromArray( printer, EndOfLine )
		  '
		  'Print ""
		  '
		  'for each g as Gate in successGates.ToArray
		  'var inNames() as string
		  'inNames.Add g.InWire1.Name
		  'inNames.Add g.InWire2.Name
		  'inNames.Sort
		  '
		  'printer.Add String.FromArray( inNames, " " + g.Op + " " ) + " -> " + g.OutWire.Name
		  'next
		  '
		  'printer.Sort
		  'Print String.FromArray( printer, EndOfLine )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function WireSorter(w1 As Wire, w2 As Wire) As Integer
		  return w1.Name.Compare( w2.Name )
		End Function
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
