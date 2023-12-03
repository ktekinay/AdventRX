#tag Class
Protected Class Advent_2020_12_08
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
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
		  return CalculateResultB( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var accumulator as integer
		  call Execute( rows, accumulator )
		  return accumulator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var rows() as string = ToStringArray( input )
		  
		  if rows.Count = 0 then
		    return -1
		  end if
		  
		  var changeRow as integer = -1
		  
		  while changeRow < rows.LastIndex
		    changeRow = changeRow + 1
		    
		    var thisRow as string = rows( changeRow )
		    
		    var parts() as string = thisRow.Split( " " )
		    var instruction as string = parts( 0 )
		    
		    if instruction = "acc" then
		      continue
		    end if
		    
		    var value as string = parts( 1 )
		    var newRow as string = thisRow
		    
		    select case instruction
		    case "jmp"
		      newRow = "nop 0" // Value is irrelevant
		      
		    case "nop"
		      newRow = "jmp " + value
		    end select
		    
		    rows( changeRow ) = newRow
		    
		    var accumulator as integer
		    if Execute( rows, accumulator ) then
		      return accumulator
		    end if
		    
		    rows( changeRow ) = thisRow
		  wend
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Execute(rows() As String, ByRef accumulator As Integer) As Boolean
		  var row as integer
		  var stack as new Dictionary
		  var isFinished as boolean = true
		  
		  do
		    if stack.HasKey( row ) then
		      isFinished = false
		      exit
		    end if
		    stack.Value( row ) = nil
		    
		    var parts() as string = rows( row ).Split( " " )
		    var instruction as string = parts( 0 )
		    var value as integer = parts( 1 ).ToInteger
		    
		    select case instruction
		    case "nop"
		      row = row + 1
		      
		    case "acc"
		      accumulator = accumulator + value
		      row = row + 1
		      
		    case "jmp"
		      row = row + value
		      
		    end select
		    
		  loop until row > rows.LastIndex
		  
		  return isFinished
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6", Scope = Private
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
