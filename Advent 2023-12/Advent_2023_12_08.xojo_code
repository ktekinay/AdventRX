#tag Class
Protected Class Advent_2023_12_08
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Follow instructions to count steps from start to finish"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Haunted Wasteland"
		  
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
		  var instructions() as string
		  var map as new Dictionary
		  ParseInput( input, instructions, map )
		  
		  var count as integer = CountPath( "AAA", "ZZZ", instructions, map )
		  
		  return count : if( IsTest, 6, 12083 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var instructions() as string
		  var map as new Dictionary
		  ParseInput( input, instructions, map )
		  
		  var currents() as string
		  for each key as string in map.Keys
		    if key.EndsWith( "A" ) then
		      currents.Add key
		    end if
		  next
		  
		  var counts() as integer
		  counts.ResizeTo currents.LastIndex
		  
		  for curIndex as integer = 0 to currents.LastIndex
		    var current as string = currents( curIndex )
		    counts( curIndex ) = CountPath( current, "Z", instructions, map )
		  next
		  
		  var count as integer = LeastCommonMultiple( counts )
		  
		  return count : if( IsTest, 6, 13385272668829 )
		  // 13,385,272,668,829
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountPath(current As String, target As String, instructions() As String, map As Dictionary) As Integer
		  var count as integer
		  var instructionIndex as integer = -1
		  
		  do
		    count = count + 1
		    instructionIndex = ( instructionIndex + 1 ) mod instructions.Count
		    var instruction as string = instructions( instructionIndex )
		    
		    var nextStep as pair = map.Value( current )
		    if instruction = "L" then
		      current = nextStep.Left
		    else
		      current = nextStep.Right
		    end if
		  loop until current.EndsWith( target )
		  
		  return count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, ByRef toInstructions() As String, toMap As Dictionary)
		  input = input.ReplaceAllBytes( " = (", " " ).ReplaceAllBytes( ")", "" ).ReplaceAllBytes( ",", "" )
		  
		  var rows() as string = ToStringArray( input )
		  toInstructions = rows( 0 ).Split( "" )
		  
		  for i as integer = 2 to rows.LastIndex
		    var row as string = rows( i )
		    var parts() as string = row.SplitBytes( " " )
		    toMap.Value( parts( 0 ) ) = parts( 1 ) : parts( 2 )
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"LLR\n\nAAA \x3D (BBB\x2C BBB)\nBBB \x3D (AAA\x2C ZZZ)\nZZZ \x3D (ZZZ\x2C ZZZ)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"LR\n\n11A \x3D (11B\x2C XXX)\n11B \x3D (XXX\x2C 11Z)\n11Z \x3D (11B\x2C XXX)\n22A \x3D (22B\x2C XXX)\n22B \x3D (22C\x2C 22C)\n22C \x3D (22Z\x2C 22Z)\n22Z \x3D (22B\x2C 22B)\nXXX \x3D (XXX\x2C XXX)", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
