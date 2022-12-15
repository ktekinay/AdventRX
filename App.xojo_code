#tag Class
Protected Class App
Inherits DesktopApplication
	#tag MenuHandler
		Function FileParseStats() As Boolean Handles FileParseStats.Action
		  var c as new Clipboard
		  var raw as string = if( c.TextAvailable, c.Text, "" )
		  c.Close
		  c = nil
		  
		  var gmt as new TimeZone( 0 )
		  
		  var data as Dictionary
		  
		  if raw.Left( 1 ) = "{" then
		    #pragma BreakOnExceptions false
		    try
		      data = ParseJSON( raw )
		    catch err as JSONException
		      data = nil
		    end try
		    #pragma BreakOnExceptions default
		  end if
		  
		  if data is nil then
		    MessageBox "Copy the JSON data from the Advent of Code API/JSON first."
		    return true
		  end if
		  
		  var eventYear as integer = data.Value( "event" ).IntegerValue
		  WndConsole.Print "Event: " + eventYear.ToString
		  
		  var membersDict as Dictionary = data.Value( "members" )
		  
		  for each memberData as Dictionary in membersDict.Values
		    var name as string = memberData.Value( "name" )
		    var stars as integer = memberData.Value( "stars" )
		    
		    WndConsole.Print name + " (" + stars.ToString + " stars)"
		    
		    var levelsDict as Dictionary = memberData.Value( "completion_day_level" )
		    
		    for day as integer = 1 to 25
		      var dayString as string = day.ToString
		      var dayDict as Dictionary = levelsDict.Lookup( dayString, nil )
		      if dayDict is nil then
		        continue
		      end if
		      
		      var prevCompleted as new DateTime( eventYear, 12, day, 0, 0, 0, 0, TimeZone.Current )
		      'prevCompleted = new DateTime( prevCompleted.SecondsFrom1970, TimeZone.Current )
		      
		      WndConsole.Print "  Day " + dayString
		      
		      for part as integer = 1 to 2
		        var partString as string = part.ToString
		        var partDict as Dictionary = dayDict.Lookup( partString, nil )
		        if partDict is nil then
		          continue
		        end if
		        
		        var completed as new DateTime( partDict.Value( "get_star_ts" ).IntegerValue, gmt )
		        completed = new DateTime( completed.SecondsFrom1970, TimeZone.Current )
		        
		        var elapsed as double = completed.SecondsFrom1970 - prevCompleted.SecondsFrom1970
		        
		        WndConsole.Print "    " + partString + ": " + completed.ToString + " (" + ToHMS( elapsed ) + ")"
		        
		        prevCompleted = completed
		      next
		    next
		    
		  next
		  
		  return true
		End Function
	#tag EndMenuHandler


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
