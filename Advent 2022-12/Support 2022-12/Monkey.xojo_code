#tag Class
Protected Class Monkey
	#tag Method, Flags = &h21
		Private Function ApplyOperation(worry As Integer) As Integer
		  var old as integer = worry
		  var op as string = self.Operation
		  
		  op = op.ReplaceAll( "old", old.ToString )
		  
		  var parts() as string = op.Split( " " )
		  var val1 as integer = parts( 0 ).ToInteger
		  var val2 as integer = parts( 2 ).ToInteger
		  
		  select case parts( 1 )
		  case "+"
		    return val1 + val2
		  case "-"
		    return val1 - val2
		  case "*" 
		    return val1 * val2
		  case "/"
		    return val1 / val2
		  case else
		    raise new RuntimeException
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Inspect(worry As Integer, monkeys() As Monkey)
		  InspectionCount = InspectionCount + 1
		  
		  worry = ApplyOperation( worry )
		  if DoDivideBy3 then
		    worry = worry \ 3
		  else
		    worry = worry mod LCM
		  end if
		  
		  var mIndex as integer
		  if ( worry mod Test ) = 0 then
		    mIndex = TrueMonkey
		  else
		    mIndex = FalseMonkey
		  end if
		  
		  monkeys( mIndex ).Items.Add worry
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessItems(monkeys() As Monkey)
		  var items() as integer = self.Items
		  var empty() as integer
		  self.Items = empty
		  
		  for each worry as integer in items
		    Inspect worry, monkeys
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DoDivideBy3 As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		FalseMonkey As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Index As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		InspectionCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Items() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Shared LCM As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Operation As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Test As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TrueMonkey As Integer
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
		#tag ViewProperty
			Name="Operation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TrueMonkey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FalseMonkey"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Test"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InspectionCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoDivideBy3"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
