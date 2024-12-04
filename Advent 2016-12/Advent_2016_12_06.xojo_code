#tag Class
Protected Class Advent_2016_12_06
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Decode a message using frequency of letters"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Signals and Noise"
		  
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
		Private Function CalculateResultA(input As String) As Variant
		  var result as string
		  
		  input = Normalize( input )
		  
		  var rows() as string = input.Split( EndOfLine )
		  
		  var lastColIndex as integer = rows( 0 ).Bytes - 1
		  
		  var mb as MemoryBlock = input.ReplaceAll( EndOfLine , "" )
		  var p as ptr = mb
		  
		  var aVal as integer = asc( "a" )
		  
		  for col as integer = 0 to lastColIndex
		    var freqs( 25 ) as integer
		    var letters() as string = Split( "abcdefghijklmnopqrstuvwxyz", "" )
		    
		    for row as integer = 0 to rows.LastIndex
		      var byteIndex as integer = ( row * ( lastColIndex + 1 ) ) + col
		      var b as integer = p.Byte( byteIndex )
		      var arrIndex as integer = b - aVal
		      
		      freqs( arrIndex ) = freqs( arrIndex ) + 1
		    next
		    
		    freqs.SortWith letters
		    
		    result = result + letters( letters.LastIndex )
		  next
		  
		  return result : if( IsTest, "easter", "tkspfjcc" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var result as string
		  
		  input = Normalize( input )
		  
		  var rows() as string = input.Split( EndOfLine )
		  
		  var lastColIndex as integer = rows( 0 ).Bytes - 1
		  
		  var mb as MemoryBlock = input.ReplaceAll( EndOfLine , "" )
		  var p as ptr = mb
		  
		  var aVal as integer = asc( "a" )
		  
		  for col as integer = 0 to lastColIndex
		    var freqs( 25 ) as integer
		    var letters() as string = Split( "abcdefghijklmnopqrstuvwxyz", "" )
		    
		    for row as integer = 0 to rows.LastIndex
		      var byteIndex as integer = ( row * ( lastColIndex + 1 ) ) + col
		      var b as integer = p.Byte( byteIndex )
		      var arrIndex as integer = b - aVal
		      
		      freqs( arrIndex ) = freqs( arrIndex ) + 1
		    next
		    
		    freqs.SortWith letters
		    
		    var pos as integer
		    for i as integer = 0 to freqs.LastIndex
		      if freqs( i ) <> 0 then
		        pos = i
		        exit
		      end if
		    next
		    
		    result = result + letters(pos )
		  next
		  
		  return result : if( IsTest, "advent", "xrlmbypn" )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"eedadn\ndrvtee\neandsr\nraavrd\natevrs\ntsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\nsvetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\nenarar", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


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
