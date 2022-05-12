#tag Class
Protected Class Advent_2020_12_13
Inherits AdventBase
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
		Private Function ArePrime(nums() As Integer, maxNum As Integer) As Boolean
		  var notPrime() as boolean
		  notPrime.ResizeTo maxNum
		  
		  for i as integer = 4 to maxNum step 2
		    notPrime( i ) = true
		  next
		  
		  for outer as integer = 3 to maxNum step 2
		    if notPrime( outer ) then
		      continue
		    end if
		    
		    var startIndex as integer = outer * outer
		    var stepper as integer = outer * 2
		    
		    for inner as integer = startIndex to maxNum step stepper
		      notPrime( inner ) = true
		    next
		  next
		  
		  for each num as integer in nums
		    if num = 0 then
		      continue
		    end if
		    
		    if notPrime( num ) then
		      return false
		    end if
		  next
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var earliest as integer = rows( 0 ).ToInteger
		  
		  var ids() as integer
		  for each busId as string in rows( 1 ).Split( "," )
		    if busId <> "x" then
		      ids.Add busId.ToInteger
		    end if
		  next
		  
		  var maxWait as integer = 999999999
		  var bestId as integer = -1
		  
		  for each id as integer in ids
		    var diff as integer = earliest mod id
		    var wait as integer = id - diff
		    if wait < maxWait then
		      maxWait = wait
		      bestId = id
		    end if
		  next
		  
		  return bestId * maxWait
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  #pragma BoundsChecking false
		  #pragma NilObjectChecking  false
		  #pragma StackOverflowChecking false
		  
		  var ids() as integer
		  
		  for each busId as string in rows( 1 ).Split( "," )
		    var id as integer = busId.ToInteger
		    ids.Add id
		  next
		  
		  var increments() as integer
		  increments.ResizeTo ids.LastIndex
		  for i as integer = 0 to increments.LastIndex
		    increments( i ) = i
		  next
		  
		  for i as integer = ids.LastIndex downto 0
		    if ids( i ) = 0 then
		      ids.RemoveAt i
		      increments.RemoveAt i
		    end if
		  next
		  
		  var tester as integer = ids( 0 )
		  if IsTest then
		    tester = ids( 0 )
		  end if
		  
		  var interval as integer = ids( 0 )
		  var currentInARow as integer = 1
		  var nextInARow as integer = 2
		  var currentInARowInterval as integer = interval
		  
		  do
		    var inARow as integer
		    for i as integer = 0 to ids.LastIndex
		      var id as integer = ids( i )
		      var departureTime as integer = tester + increments( i )
		      if departureTime mod id = 0 then
		        inARow = inARow + 1
		      else
		        exit
		      end if
		    next
		    
		    if inARow = 2 then
		      inARow = inARow
		    end if
		    
		    if inARow = ids.Count then
		      return tester
		    end if
		    
		    if inARow >= nextInARow then
		      if currentInARow < nextInARow then
		        currentInARowInterval = tester
		        currentInARow = nextInARow
		      else
		        interval = tester - currentInARowInterval
		        nextInARow = nextInARow + 1
		      end if
		    end if
		    
		    tester = tester + interval
		  loop
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"939\n7\x2C13\x2Cx\x2Cx\x2C59\x2Cx\x2C31\x2C19", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
