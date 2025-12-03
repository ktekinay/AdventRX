#tag Class
Protected Class Advent_2025_12_03
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Highest combination of numbers per row"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Lobby"
		  
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
		  var rows() as string = input.Trim.Split( EndOfLine )
		  
		  var sum as integer
		  
		  for each row as string in rows
		    var rowArr( 9 ) as variant = NewRowArray( row )
		    
		    var thisSum as integer = NextValue( 2, rowArr, 0, -1 )
		    sum = sum + thisSum
		  next
		  
		  return sum : if( IsTest, 357, 17229 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = input.Trim.Split( EndOfLine )
		  
		  var sum as integer
		  
		  for each row as string in rows
		    var rowArr( 9 ) as variant = NewRowArray( row )
		    
		    var thisSum as integer = NextValue( 12, rowArr, 0, -1 )
		    sum = sum + thisSum
		  next
		  
		  return sum : if( IsTest, 3121910778619, 170520923035051 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NewRowArray(row As String) As Variant()
		  var rowArr( 9 ) as variant
		  
		  var ratings() as string = row.Split( "" )
		  
		  for position as integer = 0 to ratings.LastIndex
		    var rating as integer = ratings( position ).ToInteger
		    
		    var indexes() as integer
		    if rowArr( rating ) is nil then
		      rowArr( rating ) = indexes
		    else
		      indexes = rowArr( rating )
		    end if
		    
		    indexes.Add position
		  next
		  
		  return rowArr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function NextValue(count As Integer, rowArr() As Variant, previousValue As Integer, previousIndex As Integer, runningSum As integer = 0) As Integer
		  for thisValue as integer = 9 downto 1
		    if rowArr( thisValue ) is nil then
		      continue
		    end if
		    
		    var indexes() as integer = rowArr( thisValue )
		    
		    for each index as integer in indexes
		      if index <= previousIndex then
		        continue
		      end if
		      
		      if count = 1 then
		        return runningSum * 10 + thisValue
		      end if
		      
		      var sum as integer = NextValue( count - 1, rowArr, thisValue, index, runningSum * 10 + thisValue )
		      
		      if sum = -1 then
		        continue for thisValue
		      end if
		      
		      return sum
		      
		    next
		  next
		  
		  return -1
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"987654321111111\n811111111111119\n234234234234278\n818181911112111", Scope = Private
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
