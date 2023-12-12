#tag Class
Protected Class Advent_2023_12_12
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
		Private Function CalculateResultA(input As String) As Variant
		  var rows() as string = ToStringArray( input )
		  
		  var counts() as integer
		  for each row as string in rows
		    var parts() as string = row.Split( " " )
		    var springs as string = parts( 0 )
		    var patterns() as integer = ToIntegerArray( parts( 1 ).Split( "," ) )
		    
		    counts.Add CountArrangements( springs, patterns )
		  next
		  
		  var count as integer = SumArray( counts )
		  return count : if( IsTest, 21, 7163 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  const kRepeat as integer = 5
		  
		  var rows() as string = ToStringArray( input )
		  
		  var count as integer
		  for each row as string in rows
		    var parts() as string = row.Split( " " )
		    parts( 0 ) = Duplicate( parts( 0 ), kRepeat, "?" )
		    parts( 1 ) = Duplicate( parts( 1 ), kRepeat, "," )
		    
		    var springs as string = parts( 0 )
		    var patterns() as integer = ToIntegerArray( parts( 1 ).Split( "," ) )
		    
		    count = count + CountArrangements( springs, patterns )
		  next
		  
		  return count : if( IsTest, 525152, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountArrangements(springs As MemoryBlock, patterns() As Integer, springIndex As Integer = 0) As Integer
		  if springIndex >= springs.Size then
		    var count as integer = Matches( springs, patterns )
		    if count = 1 then
		      count = count
		    end if
		    
		    return count
		  end if
		  
		  var p as ptr = springs
		  
		  var spring as integer = p.Byte( springIndex )
		  if spring <> kQuestionMark then
		    return CountArrangements( springs, patterns, springIndex + 1 )
		  end if
		  
		  var count as integer
		  
		  p.Byte( springIndex ) = kHash
		  count = CountArrangements( springs, patterns, springIndex + 1 )
		  
		  p.Byte( springIndex ) = kDot
		  count = count + CountArrangements( springs, patterns, springIndex + 1 )
		  
		  p.Byte( springIndex ) = spring
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Duplicate(s As String, repeat As Integer, joiner As String) As String
		  var arr() as string
		  arr.ResizeTo repeat - 1
		  
		  for i as integer = 0 to arr.LastIndex
		    arr( i ) = s
		  next
		  
		  return String.FromArray( arr, joiner )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Matches(springs As MemoryBlock, patterns() As Integer) As Integer
		  var p as ptr = springs
		  var lastByteIndex as integer = springs.Size - 1
		  
		  var existingPatterns() as integer
		  var patternCount as integer
		  
		  for i as integer = 0 to lastByteIndex
		    if p.Byte( i ) = kDot then
		      if patternCount <> 0 then
		        if existingPatterns.LastIndex = patterns.LastIndex then
		          return 0
		        end if
		        
		        if patterns( existingPatterns.Count ) <> patternCount then
		          return 0
		        end if
		        
		        existingPatterns.Add patternCount
		        patternCount = 0
		      end if
		      
		    else
		      patternCount = patternCount + 1
		      
		    end if
		  next
		  
		  if patternCount <> 0 then
		    existingPatterns.Add patternCount
		  end if
		  
		  if existingPatterns.LastIndex <> patterns.LastIndex then
		    return 0
		  end if
		  
		  if existingPatterns( existingPatterns.LastIndex ) <> patterns( patterns.LastIndex ) then
		    return 0
		  end if
		  
		  return 1
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kDot, Type = Double, Dynamic = False, Default = \"46", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kHash, Type = Double, Dynamic = False, Default = \"35", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kQuestionMark, Type = Double, Dynamic = False, Default = \"63", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"\?\?\?.### 1\x2C1\x2C3\n.\?\?..\?\?...\?##. 1\x2C1\x2C3\n\?#\?#\?#\?#\?#\?#\?#\? 1\x2C3\x2C1\x2C6\n\?\?\?\?.#...#... 4\x2C1\x2C1\n\?\?\?\?.######..#####. 1\x2C6\x2C5\n\?###\?\?\?\?\?\?\?\? 3\x2C2\x2C1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
	#tag EndUsing


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
