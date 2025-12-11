#tag Class
Protected Class Advent_2025_12_11
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Count paths from one device to another"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Reactor"
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  if kTestInput <> "" then
		    return CalculateResultA( Normalize( kTestInput ) )
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  if input <> "" then
		    return CalculateResultB( Normalize( input ) )
		  end if
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var devices as Dictionary = ToDevices( input )
		  
		  'var count as integer = Trace( "you", devices )
		  var count as integer = TraceTrail( "you", "out", devices )
		  
		  var testAnswer as variant = 5
		  var answer as variant = 566
		  
		  return count : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var count as integer
		  
		  if CanReach( "dac", "fft", ToDevices( input ) ) then
		    count = TraceTrail( "dac", "out", ToDevices( input ) )
		    count = count * TraceTrail( "fft", "dac", ToDevices( input ) )
		    count = count * TraceTrail( "svr", "fft", ToDevices( input ) )
		  else
		    count = TraceTrail( "fft", "out", ToDevices( input ) )
		    count = count * TraceTrail( "dac", "fft", ToDevices( input ) )
		    count = count * TraceTrail( "svr", "dac", ToDevices( input ) )
		  end if
		  
		  var testAnswer as variant = 2
		  var answer as variant = 331837854931968
		  
		  return count : if( IsTest, testAnswer, answer )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CanReach(goal As String, device As String, devices As Dictionary) As Boolean
		  if device = goal then
		    return true
		  elseif device = "out" then
		    return false
		  end if
		  
		  var entry as variant = devices.Value( device )
		  
		  if entry.Type = Variant.TypeBoolean then
		    return entry.BooleanValue
		  end if
		  
		  var nextPaths() as string = entry.StringValue.Split( " " )
		  
		  for each p as string in nextPaths
		    if CanReach( goal, p, devices ) then
		      return true
		    end if
		  next
		  
		  devices.Value( device ) = false
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ToDevices(input As String) As Dictionary
		  var rows() as string = ToStringArray( input )
		  
		  var devices as new Dictionary
		  
		  for each row as string in rows
		    var parts() as string = row.Split( ": " )
		    devices.Value( parts( 0 ) ) = parts( 1 )
		  next
		  
		  return devices
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function TraceTrail(device As String, goal As String, devices As Dictionary) As Integer
		  if device = goal then
		    return 1
		  elseif device = "out" then
		    return 0 
		  end if
		  
		  var entry as variant = devices.Value( device )
		  
		  if entry.Type = Variant.TypeInt64 then
		    return entry.IntegerValue
		  end if
		  
		  var nextPaths() as string  = entry.StringValue.Split( " " )
		  
		  var count as integer
		  
		  for each p as string in nextPaths
		    count = count + TraceTrail( p, goal, devices )
		  next
		  
		  devices.Value( device ) = count
		  
		  return count
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"aaa: you hhh\nyou: bbb ccc\nbbb: ddd eee\nccc: ddd eee fff\nddd: ggg\neee: out\nfff: out\nggg: out\nhhh: ccc fff iii\niii: out", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"svr: aaa bbb\naaa: fft\nfft: ccc\nbbb: tty\ntty: ccc\nccc: ddd eee\nddd: hub\nhub: fff\neee: dac\ndac: fff\nfff: ggg hhh\nggg: out\nhhh: out", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2025
	#tag EndUsing


	#tag ViewBehavior
		#tag ViewProperty
			Name="Type"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Cooperative"
				"1 - Preemptive"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
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
