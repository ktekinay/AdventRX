#tag Class
Protected Class Advent_2021_12_02
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var arr() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var depth as integer
		  var horiz as integer
		  
		  for each item as string in arr
		    var parts() as string = item.Split( " " )
		    var instruction as string = parts( 0 )
		    var value as integer = parts( 1 ).ToInteger
		    
		    select case instruction
		    case "forward"
		      horiz = horiz + value
		      
		    case "up"
		      depth = depth - value
		      
		    case "down"
		      depth = depth + value
		      
		    end select
		  next
		  
		  return depth * horiz
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var arr() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var depth as integer
		  var horiz as integer
		  var aim as integer
		  
		  for each item as string in arr
		    var parts() as string = item.Split( " " )
		    var instruction as string = parts( 0 )
		    var value as integer = parts( 1 ).ToInteger
		    
		    select case instruction
		    case "forward"
		      horiz = horiz + value
		      depth = depth + ( aim * value )
		      
		    case "up"
		      aim = aim - value
		      
		    case "down"
		      aim = aim + value
		      
		    end select
		  next
		  
		  return depth * horiz
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"forward 9\nforward 7\ndown 7\ndown 3\nforward 2\nforward 3\nforward 7\ndown 6\nforward 7\ndown 7\nforward 9\ndown 9\nup 2\ndown 5\nup 1\nforward 5\nforward 6\nup 4\ndown 3\ndown 4\ndown 5\nup 6\ndown 3\nforward 6\nforward 4\ndown 4\nforward 5\ndown 2\nup 1\nup 8\ndown 1\ndown 6\nforward 8\ndown 4\nforward 8\nforward 6\nforward 2\nforward 2\nforward 3\nforward 8\nup 9\nup 2\ndown 3\nup 3\nforward 5\nforward 2\nup 5\nforward 9\ndown 7\ndown 2\nup 7\ndown 4\ndown 6\nup 2\ndown 9\nforward 7\ndown 8\nforward 6\nup 1\nforward 6\nforward 4\ndown 5\nforward 6\ndown 8\ndown 3\nforward 7\ndown 8\nup 7\ndown 1\nup 1\nforward 9\ndown 7\nup 3\ndown 6\ndown 6\ndown 6\ndown 7\ndown 9\ndown 6\ndown 9\ndown 8\ndown 3\ndown 7\ndown 3\nup 8\ndown 5\ndown 9\nup 4\nforward 5\nforward 5\nforward 2\nup 1\nforward 6\ndown 6\ndown 2\nforward 1\nforward 8\ndown 4\ndown 1\ndown 8\ndown 7\nforward 6\nforward 8\ndown 8\nup 1\nup 1\nforward 1\nforward 3\nup 8\ndown 1\nforward 4\ndown 3\nforward 3\nforward 4\nforward 3\ndown 3\ndown 9\ndown 3\nup 6\nforward 6\nforward 8\nforward 2\nup 1\nup 4\nup 4\ndown 2\ndown 2\ndown 2\nforward 7\nup 9\ndown 9\nup 1\ndown 5\nforward 4\ndown 2\ndown 4\nforward 3\ndown 7\ndown 9\nforward 1\nup 5\ndown 5\ndown 5\nforward 2\ndown 6\nforward 8\nup 4\nforward 6\nup 1\ndown 4\nforward 2\ndown 9\nforward 5\ndown 7\ndown 8\ndown 9\nforward 6\nup 6\nforward 9\nforward 9\ndown 7\nforward 7\nforward 5\nup 9\nforward 3\ndown 9\ndown 1\ndown 8\ndown 4\nforward 5\nforward 6\nforward 8\nforward 8\ndown 4\ndown 3\ndown 8\nforward 3\ndown 6\ndown 8\ndown 2\nup 8\nup 9\ndown 6\nforward 3\ndown 4\ndown 6\nforward 9\nforward 6\nup 2\ndown 8\nforward 2\ndown 7\nforward 9\nup 9\ndown 9\ndown 2\nforward 9\ndown 4\ndown 9\nup 4\nforward 6\ndown 2\ndown 9\nforward 8\nforward 2\nup 8\nforward 9\nforward 2\nforward 3\ndown 2\nup 3\nforward 9\ndown 6\ndown 3\ndown 1\nforward 9\nforward 8\ndown 9\nup 7\ndown 8\nup 7\nforward 1\nforward 1\nforward 7\ndown 2\ndown 1\nup 1\nup 6\ndown 5\nup 9\nup 7\nforward 1\nforward 6\nforward 1\nup 4\ndown 6\nforward 2\nup 7\ndown 2\nup 8\nforward 9\nforward 6\nforward 3\nforward 8\ndown 1\nforward 8\nup 3\nforward 1\nforward 1\nup 9\ndown 1\ndown 8\ndown 2\nforward 8\ndown 8\nforward 7\ndown 5\nforward 8\nforward 3\nforward 6\nforward 7\nup 5\ndown 5\nforward 8\ndown 2\nforward 3\ndown 4\ndown 9\nforward 6\nforward 5\nup 4\nforward 7\ndown 3\nforward 9\nforward 5\ndown 3\nup 5\nforward 4\nforward 8\ndown 7\nup 2\nforward 7\ndown 5\nup 2\ndown 9\nforward 4\ndown 3\nforward 5\nforward 4\ndown 3\nforward 6\nup 1\nforward 8\ndown 1\nup 7\nforward 8\nup 1\nup 1\nforward 2\ndown 8\nforward 4\nforward 8\nup 6\nforward 5\nforward 7\nup 6\nup 4\nup 6\ndown 1\nforward 3\ndown 1\ndown 1\ndown 8\nforward 8\ndown 5\ndown 5\nforward 5\nforward 9\ndown 9\nforward 7\ndown 3\ndown 5\nforward 6\ndown 1\ndown 5\nup 8\ndown 9\nforward 3\ndown 6\nup 2\ndown 2\nforward 2\nup 2\nforward 8\ndown 2\nforward 9\nforward 2\ndown 7\ndown 5\nforward 1\nforward 7\nup 6\nup 8\nforward 8\nforward 8\nup 3\nforward 8\ndown 6\ndown 6\nforward 4\ndown 8\ndown 5\ndown 7\nforward 1\nforward 9\nforward 9\nup 5\ndown 9\ndown 1\nforward 4\nforward 1\nup 9\nforward 6\ndown 6\nforward 2\nup 6\nforward 9\nup 1\ndown 2\nup 3\nforward 2\nforward 1\nforward 6\ndown 9\nup 1\nforward 7\nup 3\nforward 6\nforward 6\nup 2\ndown 8\nforward 4\ndown 4\nforward 2\nforward 2\ndown 4\ndown 7\ndown 4\ndown 5\nforward 3\ndown 1\nforward 1\nforward 8\ndown 7\nup 1\nforward 7\nforward 2\ndown 9\ndown 2\nup 2\nforward 3\ndown 4\ndown 7\ndown 8\nforward 4\nforward 5\nforward 3\nup 3\ndown 6\nforward 4\nforward 4\nforward 8\nforward 1\nup 2\nup 3\ndown 4\nup 9\nforward 1\nforward 1\nforward 9\ndown 2\ndown 5\nup 9\ndown 7\ndown 9\ndown 2\ndown 4\nforward 1\nforward 1\nforward 8\ndown 9\ndown 6\nforward 2\nup 3\ndown 8\nforward 1\nforward 8\nforward 4\nup 7\nforward 5\nforward 2\nforward 2\nup 8\ndown 5\nforward 6\ndown 3\nup 5\nforward 8\nforward 3\nforward 9\ndown 1\ndown 3\nforward 8\ndown 2\nforward 6\nforward 2\ndown 3\ndown 3\nforward 6\nforward 4\nforward 7\nforward 2\nup 7\nup 4\nup 6\nforward 9\ndown 3\ndown 3\nup 7\ndown 4\nup 3\nup 3\ndown 5\nforward 1\nup 3\ndown 1\nforward 2\nup 9\nforward 7\ndown 6\nforward 4\nforward 8\nup 1\nforward 6\ndown 7\ndown 4\nup 9\nforward 4\ndown 7\nup 1\nforward 9\ndown 4\ndown 7\nforward 1\ndown 6\ndown 6\nforward 3\nup 8\nforward 3\ndown 1\ndown 5\ndown 8\nforward 2\nup 5\nforward 2\nup 7\nforward 5\nforward 1\nforward 3\nforward 4\nforward 5\nup 1\nforward 9\ndown 5\ndown 7\nup 9\ndown 9\nforward 7\nup 6\nup 7\nforward 2\nforward 1\nup 4\nforward 6\nforward 9\ndown 1\nforward 4\ndown 5\nforward 4\ndown 3\ndown 5\nforward 6\nforward 3\ndown 3\ndown 8\ndown 2\ndown 4\ndown 6\ndown 4\nforward 2\nup 9\ndown 3\nforward 1\nforward 9\nforward 5\nforward 5\nforward 9\nup 1\ndown 4\ndown 4\nup 7\ndown 3\nup 3\nup 4\nforward 3\nforward 1\nforward 8\nup 6\ndown 8\ndown 4\nforward 7\nforward 9\nforward 2\nforward 8\nup 2\ndown 4\ndown 5\nforward 9\ndown 6\ndown 7\ndown 8\nup 8\nforward 3\nforward 7\nforward 8\nup 2\ndown 9\ndown 6\nforward 3\nforward 4\ndown 4\nforward 2\nup 6\nforward 1\nforward 7\ndown 2\ndown 1\nforward 2\nforward 2\ndown 2\nforward 2\nforward 7\nup 4\ndown 3\nforward 9\ndown 7\ndown 7\ndown 6\nforward 3\nforward 9\ndown 9\nforward 2\ndown 5\ndown 4\ndown 9\nup 9\ndown 6\ndown 8\ndown 1\nforward 8\nup 4\nup 4\ndown 8\nforward 6\ndown 2\nforward 4\nforward 3\nforward 2\nforward 4\ndown 4\nforward 6\ndown 9\nup 7\nup 5\ndown 7\ndown 4\nup 3\nforward 4\ndown 9\nforward 6\nforward 4\nforward 4\ndown 9\nforward 3\nforward 2\nup 7\nforward 3\ndown 1\ndown 3\nup 5\ndown 8\ndown 3\ndown 4\nforward 7\nforward 9\nup 2\nforward 3\nup 4\ndown 5\nup 3\nup 9\ndown 6\ndown 2\ndown 5\nup 4\nup 6\nforward 4\nforward 6\nup 5\nup 5\nforward 8\ndown 6\nforward 6\ndown 7\ndown 5\ndown 3\ndown 8\nforward 6\nforward 9\nforward 9\nup 9\ndown 3\nup 5\nforward 4\ndown 7\nforward 5\ndown 7\ndown 4\nforward 2\nforward 9\ndown 8\nup 3\nup 7\ndown 7\nup 7\nforward 3\ndown 2\nforward 7\ndown 4\nforward 1\ndown 6\nforward 1\nup 4\ndown 7\nup 3\nforward 7\nforward 5\nforward 7\nforward 6\nup 2\ndown 4\ndown 8\ndown 4\nup 3\nforward 3\nup 3\nup 3\ndown 7\ndown 2\ndown 3\nforward 7\ndown 6\ndown 9\nup 1\ndown 8\ndown 6\ndown 3\nup 2\nup 6\nforward 9\nforward 5\nforward 4\nforward 9\ndown 9\nforward 2\nup 7\ndown 4\ndown 8\nup 2\nforward 6\nup 6\nup 4\ndown 2\nforward 6\nforward 4\nup 3\ndown 6\nforward 5\nforward 3\nup 4\ndown 7\ndown 2\ndown 6\nup 7\nforward 2\nforward 1\nforward 3\ndown 2\nforward 1\nforward 2\nforward 4\ndown 2\ndown 5\ndown 7\ndown 8\ndown 1\nup 1\nup 1\nforward 9\ndown 3\ndown 1\nforward 4\nup 6\nup 8\nforward 7\nforward 9\ndown 3\nforward 9\ndown 9\nforward 6\ndown 1\nforward 7\ndown 9\nforward 1\ndown 8\nforward 8\nup 7\nforward 4\nup 5\nup 9\nforward 1\nforward 4\nforward 3\ndown 3\ndown 8\nup 3\nforward 1\nup 5\nforward 5\nup 6\nforward 8\nforward 1\ndown 7\nforward 2\ndown 9\nforward 3\nforward 7\nforward 2\ndown 4\nforward 2\nup 6\ndown 7\nup 3\nforward 7\ndown 8\ndown 3\nforward 2\nup 7\ndown 2\ndown 8\nup 6\nforward 7\nforward 1\ndown 3\nforward 2\nforward 8\ndown 8\nforward 1\ndown 7\ndown 1\nup 5\nup 3\nforward 5\ndown 5\nup 9\nup 9\ndown 3\nup 3\ndown 4\ndown 6\nup 7\nforward 3\nup 5\ndown 3\nforward 4\ndown 1\nup 1\nup 6\ndown 8\nforward 5\nup 2\ndown 5\nforward 6\nforward 4\nforward 9\ndown 9\ndown 5\nforward 5\ndown 7\ndown 7\ndown 8\nforward 3\ndown 6\nforward 5\nforward 5\ndown 6\nforward 3\ndown 7\nup 4\nup 3\ndown 5\nforward 9\nforward 9\nup 9\ndown 1\nup 2\nup 3\ndown 7\nforward 3\ndown 7\ndown 4\ndown 5\ndown 1\ndown 4\nup 9\nforward 1\nup 8\nforward 7\nup 6\ndown 1\nup 2\nforward 2\nup 9\ndown 6\nforward 4\ndown 2\nup 5\nforward 1\nforward 4\ndown 6\ndown 2\nup 8\nforward 2\nforward 8\nforward 4\ndown 9\nup 3\nforward 5\nforward 9\nforward 4\ndown 2\nup 4\nup 9\ndown 5\nup 2\nforward 6\nup 2\ndown 6\nup 5\nup 3\nup 9\nforward 8\ndown 2\nforward 7\nup 8\ndown 9\nforward 2\nforward 2\ndown 6\nforward 9\nforward 2\nforward 8\nup 3\nforward 5\ndown 4\nforward 2\ndown 7\nup 6\nforward 7\ndown 6\ndown 8\ndown 3\nup 4\nup 5\ndown 2\ndown 9\nforward 2\ndown 7\nforward 2\nforward 3\nforward 9\ndown 6\ndown 1\nforward 6\ndown 5\nforward 2\ndown 5\ndown 1\nforward 5\ndown 4\ndown 6\ndown 5\nforward 9\nup 6\nup 5\nup 2\ndown 1\ndown 8\nforward 4\ndown 2\nforward 5\ndown 1\nforward 7\ndown 8\ndown 9\ndown 7\nup 1\nforward 2\nup 8\ndown 9\ndown 2\ndown 1\ndown 9\ndown 2\ndown 5\nforward 9\nforward 1\ndown 1\nforward 9\nforward 7\ndown 6\ndown 1\ndown 7\nforward 4\nforward 1\nforward 4\nforward 5\nforward 5\ndown 2\nforward 7\nforward 6\nforward 3\nforward 9\nup 1\ndown 5\ndown 4\ndown 2\nforward 1\nup 7\nforward 2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"forward 5\ndown 5\nforward 8\nup 3\ndown 8\nforward 2", Scope = Private
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
