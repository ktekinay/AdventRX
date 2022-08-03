#tag Class
Protected Class Advent_2020_12_09
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var nums() as integer = ToIntegerArray( input )
		  return GetBadNum( nums )
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var nums() as integer = ToIntegerArray( input )
		  
		  if nums.Count = 0 then
		    return -1
		  end if
		  
		  var badNum as integer = GetBadNum( nums )
		  
		  var startIndex as integer
		  var endIndex as integer
		  
		  var sum as integer = nums( 0 )
		  
		  do
		    if sum < badNum then
		      endIndex = endIndex + 1
		      sum = sum + nums( endIndex )
		      
		    elseif sum > badNum then
		      sum = sum - nums( startIndex )
		      startIndex = startIndex + 1
		      
		      if endIndex < startIndex then
		        endIndex = startIndex
		        sum = nums( startIndex )
		      end if
		      
		    elseif sum = badNum then
		      var foundNums() as integer
		      for i as integer = startIndex to endIndex
		        foundNums.Add nums( i )
		      next
		      foundNums.Sort
		      return foundNums( 0 ) + foundNums( foundNums.LastIndex )
		      
		    end if
		  loop until startIndex >= nums.LastIndex or endIndex >= nums.LastIndex
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetBadNum(nums() As Integer) As Integer
		  var limit as integer = if( IsTest, 5, 25 )
		  
		  for i as integer = limit to nums.LastIndex
		    if not Match( i, nums, limit ) then
		      return nums( i )
		    end if
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Match(index As Integer, nums() As Integer, limit As Integer) As Boolean
		  var value as integer = nums( index )
		  
		  var startIndex as integer = index - limit
		  var endIndex as integer = index - 1
		  
		  for i1 as integer = startIndex to endIndex - 1
		    for i2 as integer = i1 + 1 to endIndex
		      var v1 as integer = nums( i1 )
		      var v2 as integer = nums( i2 )
		      if v1 = v2 then
		        continue
		      end if
		      
		      if value = ( v1 + v2 ) then
		        return true
		      end if
		    next
		  next
		  
		  return false
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"35\n20\n15\n25\n47\n40\n62\n55\n65\n95\n102\n117\n150\n182\n127\n219\n299\n277\n309\n576", Scope = Private
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
