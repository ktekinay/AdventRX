#tag Class
Protected Class Advent_2025_12_05
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Check ids against ranges"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Cafeteria"
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
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var parts() as string = input.Trim.Split( EndOfLine + EndOfLine )
		  
		  var ranges() as Advent.Range = ToRanges( parts( 0 ).Split( EndOfLine ) )
		  Combine( ranges )
		  
		  var ids() as integer = ToIntegerArray( parts( 1 ).Split( EndOfLine ) )
		  
		  var count as integer
		  
		  for each id as integer in ids
		    var firstIndex as integer = 0
		    var lastIndex as integer = ranges.LastIndex
		    
		    while firstIndex <= lastIndex
		      var index as integer = ( ( lastIndex - firstIndex ) \ 2 ) + firstIndex
		      var r as Advent.Range = ranges( index )
		      
		      if id < r.Minimum then
		        lastIndex = index - 1
		      elseif id > r.Maximum then
		        firstIndex = index + 1
		      else
		        count = count + 1
		        continue for id
		      end if
		    wend
		  next
		  
		  var testAnswer as variant = 3
		  var answer as variant = 885
		  
		  return count : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var parts() as string = input.Trim.Split( EndOfLine + EndOfLine )
		  
		  var ranges() as Advent.Range = ToRanges( parts( 0 ).Split( EndOfLine ) )
		  Combine( ranges )
		  
		  var count as integer
		  
		  for each r as Advent.Range in ranges
		    count = count + r.Length
		  next
		  
		  var testAnswer as variant = 14
		  var answer as variant = 348115621205535
		  
		  return count : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Combine(ranges() As Advent.Range)
		  ranges.Sort AddressOf Advent.Range.Sorter
		  
		  var rangeIndex as integer = ranges.LastIndex
		  
		  while rangeIndex > 0
		    var r1 as Advent.Range = ranges( rangeIndex - 1 )
		    var r2 as Advent.Range = ranges( rangeIndex )
		    
		    if r1.Overlaps( r2 ) then
		      var first as integer = min( r1.Minimum, r2.Minimum )
		      var last as integer = max( r1.Maximum, r2.Maximum )
		      
		      r1.Minimum = first
		      r1.Maximum = last
		      
		      ranges.RemoveAt( rangeIndex )
		    end if
		    
		    rangeIndex = rangeIndex - 1
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToRanges(rawRanges() As String) As Advent.Range()
		  var result() as Advent.Range
		  
		  for each rawRange as string in rawRanges
		    var parts() as string = rawRange.Split( "-" )
		    result.Add new Advent.Range( parts( 0 ).ToInteger, parts( 1 ).ToInteger )
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"3-5\n10-14\n16-20\n12-18\n\n1\n5\n8\n11\n17\n32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
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
