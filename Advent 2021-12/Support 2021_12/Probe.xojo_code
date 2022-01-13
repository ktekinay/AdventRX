#tag Class
Protected Class Probe
	#tag Method, Flags = &h0
		Function Fire(xVelocity As Integer, yVelocity As Integer, target As Advent.GraphRect) As Aimings
		  Steps.RemoveAll
		  
		  var pt as new Xojo.Point
		  
		  do
		    YMax = max( YMax, pt.Y )
		    
		    if xVelocity = 0 then
		      if pt.IsLeftOf( target ) then
		        return Aimings.TooSlow
		      elseif pt.IsRightOf( target ) then
		        return Aimings.TooFast
		      elseif pt.IsBelow( target ) then
		        return Aimings.TooHigh
		      end if
		    end if
		    
		    if pt.IsBelow( target ) then
		      if pt.IsLeftOf( target ) then
		        return Aimings.TooSlow
		      elseif pt.IsRightOf( target ) then
		        return Aimings.TooFast
		      else 
		        return Aimings.TooHigh
		      end if
		    end if
		    
		    if pt.IsRightOf( target ) then
		      return Aimings.TooFast
		    end if
		    
		    steps.Add pt
		    
		    if target.Contains( pt ) then
		      return Aimings.Bullseye
		    end if
		    
		    pt.X = pt.X + xVelocity
		    pt.Y = pt.Y + yVelocity
		    
		    if xVelocity > 0 then
		      xVelocity = xVelocity - 1
		    elseif xVelocity < 0 then
		      xVelocity = xVelocity + 1
		    end if
		    
		    yVelocity = yVelocity - 1
		  loop
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Steps() As Xojo.Point
	#tag EndProperty

	#tag Property, Flags = &h0
		YMax As Integer
	#tag EndProperty


	#tag Enum, Name = Aimings, Type = Integer, Flags = &h0
		Unknown
		  Missed
		  TooFast
		  TooSlow
		  TooHigh
		Bullseye
	#tag EndEnum


	#tag ViewBehavior
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
		#tag ViewProperty
			Name="YMax"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
