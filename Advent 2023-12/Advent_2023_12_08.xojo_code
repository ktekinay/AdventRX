#tag Class
Protected Class Advent_2023_12_08
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
		Private Function AllZ(list() As String) As Boolean
		  for each item as string in list
		    if not ( item.EndsWith( "Z" ) ) then
		      return false
		    end if
		  next
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var instructions() as string = input.NthField( EndOfLine, 1 ).Split( "" )
		  
		  var map as new Dictionary
		  var rx as new RegEx
		  rx.SearchPattern = "(\w+) = \((\w+), (\w+)"
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa RegExMatch
		    map.Value( match.SubExpressionString( 1 ) ) = match.SubExpressionString( 2 ) : match.SubExpressionString( 3 )
		    
		    match = rx.Search
		  wend
		  
		  var count as integer
		  var instructionIndex as integer = -1
		  var current as string = "AAA"
		  
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
		  loop until current = "ZZZ"
		  
		  return count : if( IsTest, 6, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var instructions() as string = input.NthField( EndOfLine, 1 ).Split( "" )
		  
		  var map as new Dictionary
		  var rx as new RegEx
		  rx.SearchPattern = "(\w+) = \((\w+), (\w+)"
		  
		  var match as RegExMatch = rx.Search( input )
		  while match isa RegExMatch
		    map.Value( match.SubExpressionString( 1 ) ) = match.SubExpressionString( 2 ) : match.SubExpressionString( 3 )
		    
		    match = rx.Search
		  wend
		  
		  var count as integer
		  var instructionIndex as integer = -1
		  var current() as string
		  for each key as string in map.Keys
		    if key.EndsWith( "A" ) then
		      current.Add key
		    end if
		  next
		  
		  do
		    count = count + 1
		    instructionIndex = ( instructionIndex + 1 ) mod instructions.Count
		    var instruction as string = instructions( instructionIndex )
		    
		    for i as integer = 0 to current.LastIndex
		      var nextStep as pair = map.Value( current( i ) )
		      if instruction = "L" then
		        current( i ) = nextStep.Left
		      else
		        current( i ) = nextStep.Right
		      end if
		    next
		  loop until AllZ( current )
		  
		  return count : if( IsTest, 6, 0 )
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"LLR\n\nAAA \x3D (BBB\x2C BBB)\nBBB \x3D (AAA\x2C ZZZ)\nZZZ \x3D (ZZZ\x2C ZZZ)", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
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
