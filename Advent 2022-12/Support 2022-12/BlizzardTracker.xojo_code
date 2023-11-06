#tag Class
Protected Class BlizzardTracker
Inherits GridMember
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Event
		Function StringValue() As String
		  select case BlizzardCount
		  case 0
		    return "."
		  case is > 1
		    return BlizzardCount.ToString
		  case else
		    if UpCount <> 0 then
		      return "^"
		    elseif DownCount <> 0 then
		      return "v"
		    elseif LeftCount <> 0 then
		      return "<"
		    else
		      return ">"
		    end if
		  end select
		End Function
	#tag EndEvent


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return UpCount + DownCount + LeftCount + RightCount
			  
			End Get
		#tag EndGetter
		BlizzardCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DownCount As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if not DebugBuild
			    #pragma BoundsChecking false
			    #pragma NilObjectChecking false
			    #pragma StackOverflowChecking false
			  #endif
			  
			  return BlizzardCount = 0
			  
			End Get
		#tag EndGetter
		IsClear As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LeftCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RightCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		UpCount As Integer
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
		#tag ViewProperty
			Name="BlizzardCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsClear"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UpCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
