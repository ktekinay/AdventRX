#tag Class
Protected Class Advent_2024_12_11
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Plutonian Pebbles"
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
		  var stones() as integer = ToIntegerArray( Normalize( input ) )
		  
		  var result as integer = Solve( stones, 25 )
		  return result : if( IsTest, 55312, 218956 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  if IsTest then
		    return "" : nil
		  end if
		  
		  var result as integer
		  
		  var stones() as integer
		  
		  stones = ToIntegerArray( Normalize( input ) )
		  result = Solve( stones, 75 )
		  
		  return result : if( IsTest, 0, 259593838049805 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub Evaluate(stone As Integer, blinks As Integer, ByRef result As Integer, cache As Dictionary)
		  static lookUpArr() as integer = array( _
		  1, _
		  1 * 2024, _
		  2 * 2024, _
		  3 * 2024, _
		  4 * 2024, _
		  5 * 2024, _
		  6 * 2024, _
		  7 * 2024, _
		  8 * 2024, _
		  9 * 2024 _
		  )
		  
		  if blinks = 0 then
		    return
		  end if
		  
		  var stoneKey as string = stone.ToString
		  var key as string = stoneKey + "," + blinks.ToString
		  
		  var existing as variant = cache.Lookup( key, nil )
		  if existing.Type = Variant.TypeInt64 then
		    result = result + existing
		    return
		  end if
		  
		  var startingResult as integer = result
		  
		  for i as integer = 1 to blinks
		    if stone < 10 then
		      stone = lookUpArr( stone )
		      continue
		    end if
		    
		    existing = cache.Lookup( stone, nil )
		    
		    if existing is nil then
		      var left, right as integer
		      
		      if MaybeSplit( stone, left, right ) then
		        result = result + 1
		        
		        var values() as integer = array( left, right )
		        cache.Value( stone ) = values
		        
		        stone = left
		        Evaluate( right, blinks - i, result, cache )
		        
		      else
		        var nextStone as integer = stone * 2024
		        cache.Value( stone ) = nextStone
		        stone = nextStone
		        
		      end if
		      
		    elseif existing.IsArray then
		      result = result + 1
		      
		      var values() as integer = existing
		      stone = values( 0 )
		      Evaluate( values( 1 ), blinks - i, result, cache )
		      
		    else
		      stone = existing
		      
		    end if
		  next
		  
		  var diff as integer = result - startingResult
		  cache.Value( key ) = diff
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MaybeSplit(stone As Integer, ByRef a As Integer, ByRef b As Integer) As Boolean
		  var threshold1 as integer = 10
		  var threshold2 as integer = 100
		  var divisor as integer = 10
		  
		  do
		    if stone < threshold1 then
		      return false
		    end if
		    
		    if stone < threshold2 then
		      a = stone \ divisor
		      b = stone mod divisor
		      return true
		    end if
		    
		    threshold1 = threshold1 * 100
		    threshold2 = threshold2 * 100
		    divisor = divisor * 10
		  loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Solve(stones() As Integer, blinks As Integer) As Integer
		  var result as integer = stones.Count
		  
		  var cache as new Dictionary
		  
		  for i as integer = 0 to stones.LastIndex
		    var stone as integer = stones( i )
		    Evaluate( stone, blinks, result, cache )
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"125 17", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
