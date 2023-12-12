#tag Class
Protected Class Advent_2023_12_12
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "How many permutations fit the pattern?"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Hot Springs"
		  
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
		    var springs as string 
		    var patterns() as integer
		    var lastStartingIndex as integer
		    
		    Parse( row, 1, springs, patterns, lastStartingIndex )
		    
		    var springIndex as integer = LocateFirst( row )
		    
		    counts.Add CountArrangements( springs, patterns, springIndex, lastStartingIndex, new Dictionary )
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
		    var springs as string 
		    var patterns() as integer
		    var lastStartingIndex as integer
		    
		    Parse( row, kRepeat, springs, patterns, lastStartingIndex )
		    
		    var springIndex as integer = LocateFirst( row )
		    
		    count = count + CountArrangements( springs, patterns, springIndex, lastStartingIndex, new Dictionary )
		  next
		  
		  return count : if( IsTest, 525152, 17788038834112 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountArrangements(springs As MemoryBlock, patterns() As Integer, springIndex As Integer, lastStartingIndex As Integer, trail As Dictionary, hashCount As Integer = 0, patternIndex As Integer = 0) As Integer
		  var trailKey as integer = hashCount * 10000000 + patternIndex * 1000000 + springIndex * 100000 + lastStartingIndex
		  
		  if trail.HasKey( trailKey ) then
		    return trail.Value( trailKey )
		  end if
		  
		  var count as integer
		  
		  var p as ptr = springs
		  
		  if patternIndex > patterns.LastIndex then
		    for i as integer = springIndex to springs.Size - 1
		      if p.Byte( i ) = kHash then
		        goto Fin
		      end if
		    next
		    
		    count = 1
		    goto Fin
		  end if
		  
		  if hashCount = 0 and springIndex > lastStartingIndex then
		    goto Fin
		  end if
		  
		  var pattern as integer = patterns( patternIndex )
		  
		  if hashCount > pattern then
		    goto Fin
		  end if
		  
		  var spring as integer = p.Byte( springIndex )
		  
		  if spring <> kQuestionMark then
		    if spring = kHash then
		      hashCount = hashCount + 1
		      if hashCount > pattern then
		        goto Fin
		      end if
		      
		    elseif hashCount <> 0 then // It's a dot
		      if hashCount <> pattern then
		        goto Fin
		      end if
		      
		      hashCount = 0 
		      patternIndex = patternIndex + 1
		      lastStartingIndex = lastStartingIndex + pattern + 1
		      
		    end if
		    
		    count = CountArrangements( springs, patterns, springIndex + 1, lastStartingIndex, trail, hashCount, patternIndex )
		    goto Fin
		  end if
		  
		  //
		  // Test a hash
		  //
		  if hashCount < pattern then
		    count = count + CountArrangements( springs, patterns, springIndex + 1, lastStartingIndex, trail, hashCount + 1, patternIndex )
		  end if
		  
		  //
		  // Test a dot
		  //
		  if hashCount = 0 then
		    count = count + CountArrangements( springs, patterns, springIndex + 1, lastStartingIndex, trail, 0, patternIndex )
		  elseif hashCount = pattern then
		    count = count + CountArrangements( springs, patterns, springIndex + 1, lastStartingIndex + pattern + 1, trail, 0, patternIndex + 1 )
		  end if
		  
		  //
		  // Using evil goto because refactoring at this point was more than I wanted to do
		  //
		  Fin:
		  trail.Value( trailKey ) = count
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
		Private Function LocateFirst(s As String) As Integer
		  for i as integer = 0 to s.Bytes - 1
		    if s.MiddleBytes( i, 1 ) <> "." then
		      return i
		    end if
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parse(row As String, repeat As Integer, ByRef toSprings As String, ByRef toPatterns() As Integer, ByRef toLastStartingIndex As Integer)
		  var parts() as string = row.Split( " " )
		  if repeat > 1 then
		    parts( 0 ) = Duplicate( parts( 0 ), repeat, "?" )
		    parts( 1 ) = Duplicate( parts( 1 ), repeat, "," )
		  end if
		  
		  toSprings = parts( 0 )
		  toPatterns = ToIntegerArray( parts( 1 ).Split( "," ) )
		  
		  var patternSum as integer = SumArray( toPatterns )
		  var sepCount as integer = toPatterns.LastIndex
		  var springLen as integer = toSprings.Bytes
		  
		  toLastStartingIndex = springLen - ( patternSum + sepCount )
		  
		End Sub
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
