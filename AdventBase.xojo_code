#tag Class
Protected Class AdventBase
Inherits Thread
	#tag Event
		Sub Run()
		  DoRun
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


	#tag Method, Flags = &h21
		Private Sub DoRun()
		  var startµs as double
		  var duration as double
		  var result as integer
		  
		  mIsTest = true
		  if not CancelRun( Types.TestA ) then
		    startµs = System.Microseconds
		    result = RaiseEvent RunTestA
		    duration = System.Microseconds - startµs
		    self.AddUserInterfaceUpdate new Dictionary( Types.TestA : result, kKeyDuration : duration )
		  end if
		  
		  mIsTest = false
		  if not CancelRun( Types.A ) then
		    startµs = System.Microseconds
		    result = RaiseEvent RunA
		    duration = System.Microseconds - startµs
		    self.AddUserInterfaceUpdate new Dictionary( Types.A : result, kKeyDuration : duration )
		  end if
		  
		  mIsTest = true
		  if not CancelRun( Types.TestB ) then
		    startµs = System.Microseconds
		    result = RaiseEvent RunTestB
		    duration = System.Microseconds - startµs
		    self.AddUserInterfaceUpdate new Dictionary( Types.TestB : result, kKeyDuration : duration )
		  end if
		  
		  mIsTest = false
		  if not CancelRun( Types.B ) then
		    startµs = System.Microseconds
		    result = RaiseEvent RunB
		    duration = System.Microseconds - startµs
		    self.AddUserInterfaceUpdate new Dictionary( Types.B : result, kKeyDuration : duration )
		  else
		    self.AddUserInterfaceUpdate new Dictionary( Types.B : -1, kKeyDuration : 0.0 )
		  end if
		End Sub
	#tag EndMethod

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
		  return s.TrimRight.ReplaceLineEndings( EndOfLine )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Print(msg As Variant)
		  #pragma BackgroundTasks true
		  
		  if msg isa RowSet then
		    PrintRowSet msg
		    return
		  end if
		  
		  if msg.IsArray or msg isa Dictionary then
		    msg = GenerateJSON( msg )
		  end if
		  
		  if msg isa Pair then
		    var p as Pair = msg
		    Print p.Left, "=", p.Right
		    return
		  end if
		  
		  WndConsole.Print msg
		  'System.DebugLog "console: " + msg.StringValue
		  Thread.YieldToNext
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Print(msg1 As Variant, msg2 As Variant, ParamArray moreMsgs() As Variant)
		  #pragma BackgroundTasks true
		  
		  var printer() as string = array( msg1.StringValue, msg2.StringValue )
		  
		  for each addl as variant in moreMsgs
		    printer.Add addl.StringValue
		  next
		  
		  Print String.FromArray( printer, " " )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintRowSet(rs As RowSet)
		  #pragma BackgroundTasks true
		  
		  if rs.AfterLastRow then
		    Print "No records!"
		    return
		  end if
		  
		  while not rs.AfterLastRow
		    
		    for colIndex as integer = 0 to rs.LastColumnIndex
		      WndConsole.Print rs.ColumnAt( colIndex ).Name + ": " + rs.ColumnAt( colIndex ).StringValue
		    next
		    
		    Print "-------------------------------------"
		    
		    rs.MoveToNextRow
		  wend
		  
		  Print ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PrintStringGrid(grid(, ) As String, colDefault As String = "")
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var colMin as integer = colDefault.Length
		  
		  for row as integer = 0 to lastRowIndex
		    var builder() as string
		    for col as integer = 0 to lastColIndex
		      var item as string = grid( row, col )
		      if item.Length < colMin then
		        item = colDefault + item
		        item = item.Right( colMin )
		      end if
		      
		      builder.Add item
		    next
		    
		    Print String.FromArray( builder, "" )
		  next
		  
		  Print ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "Start" )  Sub Run()
		  Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Start()
		  if IsThreaded then
		    self.StackSize = 1024 * 1024 * 5
		    super.Start
		  else
		    DoRun
		  end if
		  
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
		Protected Function ToIntegerGrid(input As String) As Integer(,)
		  var rows() as string = input.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var grid( -1, -1 ) as integer
		  grid.ResizeTo rows.LastIndex, rows( 0 ).Bytes - 1
		  
		  for row as integer = 0 to rows.LastIndex
		    var cols() as string = rows( row ).Split( "" )
		    for col as integer = 0 to cols.LastIndex
		      grid( row, col ) = cols( col ).ToInteger
		    next
		  next
		  
		  return grid
		  
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

	#tag Method, Flags = &h1
		Protected Function ToStringGrid(input As String) As String(,)
		  var rows() as string = input.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var grid( -1, -1 ) as string
		  grid.ResizeTo rows.LastIndex, rows( 0 ).Bytes - 1
		  
		  for row as integer = 0 to rows.LastIndex
		    var cols() as string = rows( row ).Split( "" )
		    for col as integer = 0 to cols.LastIndex
		      grid( row, col ) = cols( col )
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CancelRun(type As Types) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ResultReturned(type As AdventBase.Types, result As Integer, duration As Double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReturnDescription() As String
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReturnIsComplete() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ReturnName() As String
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


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent ReturnDescription
			  
			End Get
		#tag EndGetter
		Description As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent ReturnIsComplete
			  
			End Get
		#tag EndGetter
		IsComplete As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return mIsTest
			End Get
		#tag EndGetter
		Protected IsTest As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Shared IsThreaded As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsTest As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return RaiseEvent ReturnName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

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
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
