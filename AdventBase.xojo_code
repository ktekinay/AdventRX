#tag Class
Protected Class AdventBase
Inherits Thread
	#tag Event
		Sub Run()
		  var startµs as double
		  var duration as double
		  
		  mIsTest = true
		  startµs = System.Microseconds
		  var result as integer = RaiseEvent RunTestA
		  duration = System.Microseconds - startµs
		  self.AddUserInterfaceUpdate new Dictionary( Types.TestA : result, kKeyDuration : duration )
		  
		  mIsTest = false
		  startµs = System.Microseconds
		  result = RaiseEvent RunA
		  duration = System.Microseconds - startµs
		  self.AddUserInterfaceUpdate new Dictionary( Types.A : result, kKeyDuration : duration )
		  
		  mIsTest = true
		  startµs = System.Microseconds
		  result = RaiseEvent RunTestB
		  duration = System.Microseconds - startµs
		  self.AddUserInterfaceUpdate new Dictionary( Types.TestB : result, kKeyDuration : duration )
		  
		  mIsTest = false
		  startµs = System.Microseconds
		  result = RaiseEvent RunB
		  duration = System.Microseconds - startµs
		  self.AddUserInterfaceUpdate new Dictionary( Types.B : result, kKeyDuration : duration )
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  for each d as Dictionary in data
		    var duration as double = 0.0
		    if d.HasKey( kKeyDuration ) then
		      duration = d.Value( kKeyDuration )
		      d.Remove kKeyDuration
		    end if
		    
		    var keys() as variant = d.Keys
		    var values() as variant = d.Values
		    for i as integer = 0 to keys.LastIndex
		      RaiseEvent ResultReturned( keys( i ), values( i ), duration )
		    next
		  next d
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function GetPuzzleInput() As String
		  if StoredPuzzleInput <> "" then
		    return StoredPuzzleInput
		  end if
		  
		  var data as string
		  
		  var ti as Introspection.TypeInfo = Introspection.GetType( self )
		  
		  var dataFileName as string = ti.Name + ".txt"
		  var dataFolder as FolderItem = SpecialFolder.Resource( "Puzzle Data" )
		  var dataFile as FolderItem = dataFolder.Child( dataFileName )
		  
		  
		  if dataFile.Exists then
		    var tis as TextInputStream = TextInputStream.Open( dataFile )
		    data = tis.ReadAll
		    tis.Close
		    
		  else
		    System.DebugLog "No puzzle data for " + ti.Name
		    
		  end if
		  
		  StoredPuzzleInput = data
		  return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Normalize(s As String) As String
		  return s.Trim.ReplaceLineEndings( EndOfLine )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Print(msg As Variant)
		  #pragma BackgroundTasks true
		  WndConsole.Print msg
		  'System.DebugLog "console: " + msg.StringValue
		  Thread.YieldToNext
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ToIntegerArray(s As String) As Integer()
		  s = s.ReplaceLineEndings( EndOfLine ).ReplaceAll( ",", EndOfLine ).Trim
		  var sarr() as string = s.Split( EndOfLine )
		  
		  var arr() as integer
		  for each item as string in sarr
		    arr.Add item.Trim.ToInteger
		  next
		  
		  return arr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ToStringArray(s As String) As String()
		  s = Normalize( s )
		  
		  var arr() as string
		  
		  if s <> "" then
		    arr = s.Split( EndOfLine )
		  end if
		  
		  return arr
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ResultReturned(type As AdventBase.Types, result As Integer, duration As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RunA() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RunB() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RunTestA() As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RunTestB() As Integer
	#tag EndHook


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mIsTest
			End Get
		#tag EndGetter
		Protected IsTest As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIsTest As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StoredPuzzleInput As String
	#tag EndProperty


	#tag Constant, Name = kKeyDuration, Type = String, Dynamic = False, Default = \"duration", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		TestA
		  TestB
		  A
		B
	#tag EndEnum


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
