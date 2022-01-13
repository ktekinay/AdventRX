#tag Class
Protected Class Advent_2021_12_17
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

	#tag Event
		Function RunTestB() As Integer
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var target as Advent.GraphRect = GetTarget( input )
		  
		  var yMax as integer = -999999999999
		  var p as new Probe
		  
		  for yVelocity as integer = 1 to 1000
		    var xVelocity as integer = 1
		    
		    do
		      var aim as Probe.Aimings = p.Fire( xVelocity, yVelocity, target )
		      
		      select case aim
		      case Probe.Aimings.Bullseye
		        var thisMax as integer = max( yMax, p.YMax )
		        if thisMax <> yMax then
		          yMax = thisMax
		        end if
		        continue for yVelocity
		        
		      case Probe.Aimings.TooSlow
		        
		      case Probe.Aimings.TooFast
		        exit
		        
		      case Probe.Aimings.TooHigh
		        exit
		        
		      case else
		        break
		      end select
		      
		      xVelocity = xVelocity + 1
		      if xVelocity > target.Right then
		        exit
		      end if
		    loop
		  next
		  
		  return yMax
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var target as Advent.GraphRect = GetTarget( input )
		  
		  var count as integer
		  var p as new Probe
		  
		  for yVelocity as integer = target.Bottom to 2000
		    var xVelocity as integer = 1
		    
		    do
		      var aim as Probe.Aimings = p.Fire( xVelocity, yVelocity, target )
		      
		      select case aim
		      case Probe.Aimings.Bullseye
		        count = count + 1
		        
		      case Probe.Aimings.TooSlow
		        
		      case Probe.Aimings.TooFast
		        
		      case Probe.Aimings.TooHigh
		        'exit
		        
		      case else
		        break
		      end select
		      
		      xVelocity = xVelocity + 1
		      if xVelocity > target.Right then
		        exit
		      end if
		    loop
		  next
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTarget(input As String) As Advent.GraphRect
		  // target area: x=117..164, y=-140..-89
		  
		  var rx as new RegEx
		  rx.SearchPattern = "x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)"
		  var match as RegExMatch = rx.Search( input )
		  
		  var result as new Advent.GraphRect
		  result.Left = match.SubExpressionString( 1 ).ToInteger
		  result.Right = match.SubExpressionString( 2 ).ToInteger
		  result.Top = match.SubExpressionString( 4 ).ToInteger
		  result.Bottom = match.SubExpressionString( 3 ).ToInteger
		  
		  if result.Top < result.Bottom then
		    break
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"target area: x\x3D117..164\x2C y\x3D-140..-89", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"target area: x\x3D20..30\x2C y\x3D-10..-5", Scope = Private
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
