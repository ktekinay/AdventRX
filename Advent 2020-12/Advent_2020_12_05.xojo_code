#tag Class
Protected Class Advent_2020_12_05
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var ids() as integer
		  for each row as string in rows
		    ids.Add ToId( row )
		  next
		  
		  ids.Sort
		  return ids.Pop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var ids() as integer
		  for each row as string in rows
		    ids.Add ToId( row )
		  next
		  
		  ids.Sort
		  
		  var missingIds() as integer
		  
		  for i as integer = 1 to ids.LastIndex
		    var thisId as integer = ids( i )
		    var prevId as integer = ids( i - 1 )
		    
		    if ( thisId - prevId ) = 2 then
		      missingIds.Add thisId - 1
		      print "Missing " + missingIds( missingIds.LastIndex ).ToString
		    end if
		  next
		  
		  if missingIds.Count <> 0 then
		    return missingIds( 0 )
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToId(code As String) As Integer
		  code = code.Trim.Left( 10 )
		  
		  var frontBack as string = code.Left( 7 )
		  var leftRight as string = code.Right( 3 )
		  
		  var rowLow as integer = 0
		  var rowHigh as integer = 127
		  
		  for each char as string in frontBack.Characters
		    select case char
		    case "F"
		      var midPoint as integer = ( rowHigh - rowLow ) \ 2 + rowLow
		      rowHigh = midPoint
		    case "B"
		      var midPoint as integer = ( rowHigh - rowLow + 1 ) \ 2 + rowLow
		      rowLow = midPoint
		    end select
		  next
		  
		  var leftest as integer = 0
		  var rightest as integer = 7
		  
		  for each char as string in leftRight.Characters
		    select case char
		    case "L"
		      var midPoint as integer = ( rightest - leftest ) \ 2 + leftest
		      rightest = midpoint
		    case "R"
		      var midPoint as integer = ( rightest - leftest + 1 ) \ 2 + leftest
		      leftest = midPoint
		    end select
		  next
		  
		  var row as integer = rowLow
		  var seat as integer = leftest
		  var id as integer = row * 8 + seat
		  
		  'print code + ": row " + row.ToString + ", column " + seat.ToString + ", seat ID " + id.ToString
		  return id
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"FBFBBFFRLR: row 44\x2C column 5\nBFFFBBFRRR: row 70\x2C column 7\x2C seat ID 567.\nFFFBBBFRRR: row 14\x2C column 7\x2C seat ID 119.\nBBFFBBFRLL: row 102\x2C column 4\x2C seat ID 820.", Scope = Private
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
