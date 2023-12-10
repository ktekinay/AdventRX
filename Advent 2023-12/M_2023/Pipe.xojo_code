#tag Class
Protected Class Pipe
Inherits GridMember
	#tag Method, Flags = &h0
		Function Successors() As Pipe()
		  var value as string = self.Value
		  
		  var result() as GridMember
		  
		  select case value
		  case "|"
		    result.Add Grid.Above( self )
		    result.Add Grid.Below( self )
		    
		  case "-"
		    result.Add Grid.Left( self )
		    result.Add Grid.Right( self )
		    
		  case "L"
		    result.Add Grid.Above( self )
		    result.Add Grid.Right( self )
		    
		  case "J"
		    result.Add Grid.Above( self )
		    result.Add Grid.Left( self )
		    
		  case "7"
		    result.Add Grid.Below( self )
		    result.Add Grid.Left( self )
		    
		  case "F"
		    result.Add Grid.Below( self )
		    result.Add Grid.Right( self )
		    
		  case "."
		    // Do nothing
		    
		  end select
		  
		  var pipes() as Pipe
		  for i as integer = result.LastIndex downto 0
		    if result( i ) isa object then
		      pipes.Add Pipe( result( i ) )
		    end if
		  next
		  
		  return pipes
		  
		End Function
	#tag EndMethod


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
			Name="Row"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Column"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BestSteps"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrintType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="PrintTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - UseEvent"
				"1 - UseRawValue"
				"2 - UseValue"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
