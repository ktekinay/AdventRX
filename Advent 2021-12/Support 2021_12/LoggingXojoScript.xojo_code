#tag Class
Protected Class LoggingXojoScript
Inherits XojoScript
	#tag Event
		Function CompilerError(location As XojoScriptLocation, error As XojoScript.Errors, errorInfo As Dictionary) As Boolean
		  System.DebugLog "Error at line " + location.Line.ToString + ", char " + location.Character.ToString 
		End Function
	#tag EndEvent

	#tag Event
		Sub CompilerWarning(location As XojoScriptLocation, warning As XojoScript.Warnings, warningInfo As Dictionary)
		  System.DebugLog "Warning at line " + location.Line.ToString + " char " + location.Character.ToString
		End Sub
	#tag EndEvent

	#tag Event
		Sub RuntimeError(error As RuntimeException)
		  
		End Sub
	#tag EndEvent


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
			InitialValue=""
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=true
			Group=""
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="State"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="States"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
