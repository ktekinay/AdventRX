#tag Class
Protected Class Advent_2022_12_21
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Trace values through a stack"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Monkey Math"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var dict as Dictionary = ParseInput( input )
		  Evaluate "root", dict
		  
		  return dict.Value( "root" )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var dict as Dictionary = ParseInput( input )
		  
		  dict.Remove kHuman
		  
		  var formula as string = dict.Value( "root" )
		  var parts() as string = formula.Split( " " )
		  
		  var completeName as string
		  var badName as string
		  var targetValue as integer
		  
		  for i as integer = 0 to 2 step 2
		    #pragma BreakOnExceptions false
		    try
		      Evaluate parts( i ), dict
		      completeName = parts( i )
		      targetValue = dict.Value( parts( i ) )
		      
		    catch err as KeyNotFoundException
		      badName = parts( i )
		    end try
		    #pragma BreakOnExceptions default
		  next
		  
		  FillHuman badName, targetValue, dict
		  
		  var result as integer = dict.Value( kHuman )
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Evaluate(name As String, dict As Dictionary)
		  var val as variant = dict.Value( name )
		  if val.Type = Variant.TypeInteger or val.Type = Variant.TypeInt64 then
		    return
		  end if
		  
		  var formula as string = val
		  
		  var parts() as string = formula.Split( " " )
		  
		  var wasErr as boolean
		  
		  for i as integer = 0 to 3 step 2
		    if not( parts( i ).IsNumeric ) then
		      try
		        Evaluate parts( i ), dict
		        parts( i ) = dict.Value( parts( i ) )
		      catch err as KeyNotFoundException
		        wasErr = true
		      end try
		    end if
		  next
		  
		  if wasErr then
		    dict.Value( name ) = String.FromArray( parts, " " )
		    raise new KeyNotFoundException
		  end if
		  
		  var v1 as integer = parts( 0 ).ToInteger
		  var v2 as integer = parts( 2 ).ToInteger
		  
		  var result as integer
		  
		  select case parts( 1 )
		  case "+"
		    result = v1 + v2
		  case "-"
		    result = v1 - v2
		  case "*"
		    result = v1 * v2
		  case "/"
		    result = v1 / v2
		  end select
		  
		  dict.Value( name ) = result
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FillHuman(name As String, startingValue As Integer, dict As Dictionary)
		  var val as variant = dict.Value( name )
		  if val.Type <> Variant.TypeString then
		    return
		  end if
		  
		  var formula as string = val
		  var parts() as string = formula.Split( " " )
		  
		  var unknownIndex as integer
		  var knownIndex as integer
		  var known as integer
		  
		  if parts( 0 ).IsNumeric then
		    knownIndex = 0
		    unknownIndex = 2
		  else
		    knownIndex = 2
		    unknownIndex = 0
		  end if
		  
		  known = parts( knownIndex ).ToInteger
		  
		  var desiredValue as integer = startingValue
		  
		  var op as string = parts( 1 )
		  select case op
		  case "+"
		    // unknown + d = startingValue
		    desiredValue = startingValue - known
		    
		  case "-"
		    // unknown - d = startingValue
		    // d - unknown = startingValue
		    if unknownIndex = 0 then
		      desiredValue = startingValue + known
		    else
		      desiredValue = known - startingValue
		    end if
		    
		  case "*"
		    // unknown * d = startingValue
		    desiredValue = startingValue / known
		    
		  case "/"
		    // unknown / d = startingValue
		    // d / unknown = startingValue
		    if unknownIndex = 0 then
		      desiredValue = startingValue * known
		    else
		      desiredValue = known / startingValue
		    end if
		    
		  end select
		  
		  if parts( unknownIndex ) = kHuman then
		    dict.Value( kHuman ) = desiredValue
		  end if
		  
		  FillHuman parts( unknownIndex ), desiredValue, dict
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Dictionary
		  var dict as new Dictionary
		  
		  var rows() as string = input.Split( EndOfLine )
		  for each row as string in rows
		    var parts() as string = row.Split( ": " )
		    var name as string = parts( 0 )
		    var op as string = parts( 1 )
		    
		    if op.Contains( " " ) then
		      dict.Value( name ) = op
		    else
		      dict.Value( name ) = op.ToInteger
		    end if
		  next
		  
		  return dict
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kHuman, Type = String, Dynamic = False, Default = \"humn", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"root: pppw + sjmn\ndbpl: 5\ncczh: sllz + lgvd\nzczc: 2\nptdq: humn - dvpt\ndvpt: 3\nlfqf: 4\nhumn: 5\nljgn: 2\nsjmn: drzm * dbpl\nsllz: 4\npppw: cczh / lfqf\nlgvd: ljgn * ptdq\ndrzm: hmdt - zczc\nhmdt: 32", Scope = Private
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
