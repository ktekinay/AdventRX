#tag Class
Protected Class WorkflowStep
	#tag Method, Flags = &h0
		Sub Constructor(data As String)
		  static rx as RegEx
		  if rx is nil then 
		    rx = new RegEx
		    rx.SearchPattern = "^(\w)(<|>)(\d+):(\w+)"
		  end if
		  
		  var match as RegExMatch = rx.Search( data )
		  
		  if match is nil then
		    ToWorkFlow = data
		  else
		    TestProperty = match.SubExpressionString( 1 )
		    Comparison = match.SubExpressionString( 2 )
		    CompareValue = match.SubExpressionString( 3 ).ToInteger
		    ToWorkFlow = match.SubExpressionString( 4 )
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Test(part As MachinePart) As Boolean
		  if TestProperty = "" then
		    return true
		  end if
		  
		  var partValue as integer
		  select case TestProperty
		  case "a"
		    partValue = part.A
		  case "m"
		    partValue = part.M
		  case "s"
		    partValue = part.S
		  case "x"
		    partValue = part.X
		  case else
		    break
		  end select
		  
		  select case Comparison
		  case "<"
		    return partValue < CompareValue
		  case ">"
		    return partValue > CompareValue
		  case else
		    break
		  end select
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		CompareValue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Comparison As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TestProperty As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ToWorkFlow As String
	#tag EndProperty


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
	#tag EndViewBehavior
End Class
#tag EndClass
