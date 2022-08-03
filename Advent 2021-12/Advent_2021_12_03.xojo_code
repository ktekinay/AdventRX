#tag Class
Protected Class Advent_2021_12_03
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


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  var lastCharIndex as integer = rows( 0 ).Length - 1
		  
		  var gamma as integer
		  var epsilon as integer
		  
		  for col as integer = 0 to lastCharIndex
		    var count0 as integer
		    var count1 as integer
		    
		    for each row as string in rows
		      select case row.Middle( col, 1 )
		      case "0"
		        count0 = count0 + 1
		      case "1"
		        count1 = count1 + 1
		      end select
		    next row
		    
		    if count0 < count1 then
		      gamma = Bitwise.ShiftLeft( gamma, 1 ) or 1
		      epsilon = Bitwise.ShiftLeft( epsilon,  1 )
		      
		    else
		      gamma = Bitwise.ShiftLeft( gamma, 1 )
		      epsilon = Bitwise.ShiftLeft( epsilon, 1 ) or 1
		    end if
		  next col
		  
		  return gamma * epsilon
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  var lastCharIndex as integer = rows( 0 ).Length - 1
		  
		  var o2Values() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  var co2Values() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  for col as integer = 0 to lastCharIndex
		    var count0 as integer
		    var count1 as integer
		    
		    if o2Values.Count > 1 then
		      count0 = 0
		      count1 = 0
		      
		      for each row as string in o2Values
		        select case row.Middle( col, 1 )
		        case "0"
		          count0 = count0 + 1
		          
		        case "1"
		          count1 = count1 + 1
		          
		        end select
		      next row
		      
		      if count0 <= count1 then
		        FilterOut o2Values, col, "0"
		      else
		        FilterOut o2Values, col, "1"
		      end if
		    end if
		    
		    if co2Values.Count > 1 then
		      count0 = 0
		      count1 = 0
		      
		      for each row as string in co2Values
		        select case row.Middle( col, 1 )
		        case "0"
		          count0 = count0 + 1
		          
		        case "1"
		          count1 = count1 + 1
		          
		        end select
		      next row
		      
		      if count0 <= count1 then
		        FilterOut co2Values, col, "1"
		      else
		        FilterOut co2Values, col, "0"
		      end if
		    end if
		    
		    if o2Values.Count = 1 and co2Values.Count = 1 then
		      exit
		    end if
		  next col
		  
		  var o2 as integer = Integer.FromBinary( o2Values( 0 ) )
		  var co2 as integer = Integer.FromBinary( co2Values( 0 ) ) 
		  
		  return o2 * co2
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FilterOut(arr() As String, col As Integer, filterValue As String)
		  var removeIndexes() as integer
		  
		  for i as integer = 0 to arr.LastIndex
		    if arr( i ).Middle( col, 1 ) = filterValue then
		      removeIndexes.Add i
		    end if
		  next
		  
		  if removeIndexes.Count = arr.Count then
		    return
		    
		  else
		    
		    removeIndexes.Sort
		    for i as integer = removeIndexes.LastIndex downto 0
		      arr.RemoveAt removeIndexes( i )
		    next
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010", Scope = Private
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
