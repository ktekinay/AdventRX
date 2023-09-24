#tag DesktopWindow
Begin DesktopWindow WndAdvent
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   4
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   500
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1943463935
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Advent"
   Type            =   0
   Visible         =   True
   Width           =   1106
   Begin DesktopListBox LbAdvent
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   True
      AllowFocusRing  =   False
      AllowResizableColumns=   True
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   6
      ColumnWidths    =   "300, 75"
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   3
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   460
      Index           =   -2147483648
      InitialValue    =   "Day	Status	TestA	A	TestB	B"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   1066
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  InitAdvent
		  
		  App.AllowAutoQuit = true
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddRow(advent As AdventBase)
		  var ti as Introspection.TypeInfo = Introspection.GetType( advent )
		  var name as string = ti.Name
		  name = name.Replace( "Advent_", "" )
		  name = name.ReplaceAll( "_", "-" )
		  name = name.Trim
		  
		  var parts() as string = name.Split( "-" )
		  var year as string = parts( 0 )
		  
		  var row as integer = RowOfYear( year )
		  
		  var objects() as AdventBase
		  if row = -1 then
		    LbAdvent.AddRow year
		    LbAdvent.RowTagAt( LbAdvent.LastAddedRowIndex ) = objects
		    LbAdvent.RowExpandableAt( LbAdvent.LastAddedRowIndex ) = true
		  else
		    objects = LbAdvent.RowTagAt( row )
		  end if
		  
		  objects.Add advent
		  
		  advent.Priority = Thread.HighPriority
		  advent.StackSize = 2 * 1024 * 1024
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Advent_ResultReturned(advent As AdventBase, type As AdventBase.Types, result As Integer, duration As Double)
		  for row as integer = 0 to LbAdvent.LastRowIndex
		    var rowTag as variant = LbAdvent.RowTagAt( row )
		    if rowTag is advent then
		      var col as integer
		      select case type
		      case AdventBase.Types.TestA
		        col = integer( Columns.ResultTestA )
		        
		      case AdventBase.Types.A
		        col = integer( Columns.ResultA )
		        
		      case AdventBase.Types.TestB
		        col = integer( Columns.ResultTestB )
		        
		      case AdventBase.Types.B
		        col = integer( Columns.ResultB )
		        
		        //
		        // We're done
		        //
		        EndThread row, advent
		        
		      case else
		        raise new RuntimeException
		        
		      end select
		      
		      var colText as string = result.ToString + " (" + TimeDisplay( duration ) + ")"
		      LbAdvent.CellTextAt( row, col ) = colText
		      exit
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EndThread(row As Integer, advent As AdventBase)
		  if advent.ThreadState <> Thread.ThreadStates.NotRunning then
		    advent.Stop
		    while advent.ThreadState <> Thread.ThreadStates.NotRunning
		      Thread.YieldToNext
		    wend
		  end if
		  
		  try
		    RemoveHandler advent.ResultReturned, WeakAddressOf Advent_ResultReturned
		  catch err as RuntimeException
		    // Do nothing
		  end try
		  
		  LbAdvent.CellTextAt( row, integer( Columns.Status ) ) = kLabelFinished
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandYear(year As Integer)
		  var row as integer = RowOfYear( year.ToString )
		  LbAdvent.RowExpandedAt( row ) = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub InitAdvent()
		  // 2015
		  AddRow new Advent_2015_12_01
		  AddRow new Advent_2015_12_02
		  AddRow new Advent_2015_12_03
		  AddRow new Advent_2015_12_04
		  AddRow new Advent_2015_12_05
		  AddRow new Advent_2015_12_06
		  AddRow new Advent_2015_12_07
		  AddRow new Advent_2015_12_08
		  AddRow new Advent_2015_12_09
		  AddRow new Advent_2015_12_10
		  AddRow new Advent_2015_12_11
		  AddRow new Advent_2015_12_12
		  AddRow new Advent_2015_12_13
		  
		  // 2020
		  AddRow new Advent_2020_12_01
		  AddRow new Advent_2020_12_02
		  AddRow new Advent_2020_12_03
		  AddRow new Advent_2020_12_04
		  AddRow new Advent_2020_12_05
		  AddRow new Advent_2020_12_06
		  AddRow new Advent_2020_12_07
		  AddRow new Advent_2020_12_08
		  AddRow new Advent_2020_12_09
		  AddRow new Advent_2020_12_10
		  AddRow new Advent_2020_12_11
		  AddRow new Advent_2020_12_12
		  AddRow new Advent_2020_12_13
		  AddRow new Advent_2020_12_14
		  AddRow new Advent_2020_12_15
		  AddRow new Advent_2020_12_16
		  AddRow new Advent_2020_12_17
		  AddRow new Advent_2020_12_18
		  AddRow new Advent_2020_12_19
		  AddRow new Advent_2020_12_20
		  AddRow new Advent_2020_12_21
		  AddRow new Advent_2020_12_22
		  AddRow new Advent_2020_12_23
		  AddRow new Advent_2020_12_24
		  AddRow new Advent_2020_12_25
		  
		  // 2021
		  AddRow new Advent_2021_12_01
		  AddRow new Advent_2021_12_02
		  AddRow new Advent_2021_12_03
		  AddRow new Advent_2021_12_04
		  AddRow new Advent_2021_12_05
		  AddRow new Advent_2021_12_06
		  AddRow new Advent_2021_12_07
		  AddRow new Advent_2021_12_08
		  AddRow new Advent_2021_12_09
		  AddRow new Advent_2021_12_10
		  AddRow new Advent_2021_12_11
		  AddRow new Advent_2021_12_12
		  AddRow new Advent_2021_12_13
		  AddRow new Advent_2021_12_14
		  AddRow new Advent_2021_12_15
		  AddRow new Advent_2021_12_16
		  AddRow new Advent_2021_12_17
		  AddRow new Advent_2021_12_18
		  AddRow new Advent_2021_12_19
		  AddRow new Advent_2021_12_20
		  AddRow new Advent_2021_12_21
		  AddRow new Advent_2021_12_22
		  AddRow new Advent_2021_12_23
		  AddRow new Advent_2021_12_24
		  AddRow new Advent_2021_12_25
		  
		  // 2022
		  AddRow new Advent_2022_12_01
		  AddRow new Advent_2022_12_02
		  AddRow new Advent_2022_12_03
		  AddRow new Advent_2022_12_04
		  AddRow new Advent_2022_12_05
		  AddRow new Advent_2022_12_06
		  AddRow new Advent_2022_12_07
		  AddRow new Advent_2022_12_08
		  AddRow new Advent_2022_12_09
		  AddRow new Advent_2022_12_10
		  AddRow new Advent_2022_12_11
		  AddRow new Advent_2022_12_12
		  AddRow new Advent_2022_12_13
		  AddRow new Advent_2022_12_14
		  AddRow new Advent_2022_12_15
		  AddRow new Advent_2022_12_16
		  AddRow new Advent_2022_12_17
		  AddRow new Advent_2022_12_18
		  AddRow new Advent_2022_12_19
		  AddRow new Advent_2022_12_20
		  AddRow new Advent_2022_12_21
		  AddRow new Advent_2022_12_22
		  AddRow new Advent_2022_12_23
		  AddRow new Advent_2022_12_24
		  AddRow new Advent_2022_12_25
		  
		  // 2023
		  AddRow new Advent_2023_12_01
		  
		  // Expand
		  ExpandYear 2022
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowOfYear(year As String) As Integer
		  for row as integer = 0 to LbAdvent.LastRowIndex
		    if LbAdvent.CellTextAt( row, integer( Columns.Name ) ) = year then
		      return row
		    end if
		  next
		  return - 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TimeDisplay(µs As Double) As String
		  var result as string
		  
		  var duration as double = µs
		  var unit as string
		  
		  select case µs
		  case is >= 45000000.0
		    duration = µs / 60000000.0
		    unit = "M"
		    
		  case is >= 750000.0
		    duration = µs / 1000000.0
		    unit = "s"
		    
		  case is >= 750.0
		    duration = µs / 1000.0
		    unit = "ms"
		    
		  case else
		    unit = "µs"
		    
		  end select
		  
		  result = duration.ToString( "#,##0.0#" ) + " " + unit
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kLabelFinished, Type = String, Dynamic = False, Default = \"Done", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kLabelPaused, Type = String, Dynamic = False, Default = \"Paused", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kLabelRunning, Type = String, Dynamic = False, Default = \"Running...", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kMenuCopy, Type = String, Dynamic = False, Default = \"Copy", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kMenuKill, Type = String, Dynamic = False, Default = \"Kill", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Columns, Type = Integer, Flags = &h21
		Name
		  Status
		  ResultTestA
		  ResultA
		  ResultTestB
		ResultB
	#tag EndEnum


#tag EndWindowCode

#tag Events LbAdvent
	#tag Event
		Sub DoublePressed()
		  var row as integer = me.SelectedRowIndex
		  if row < 0 or row > me.LastRowIndex then
		    return
		  end if
		  
		  if me.RowExpandableAt( row ) then
		    me.RowExpandedAt( row ) = not me.RowExpandedAt( row )
		    return
		  end if
		  
		  var advent as AdventBase = me.RowTagAt( row )
		  
		  var status as string
		  
		  if advent.ThreadState = Thread.ThreadStates.NotRunning then
		    for column as integer = integer( Columns.ResultTestA ) to integer( Columns.ResultB )
		      me.CellTextAt( row, column ) = ""
		    next
		    
		    AddHandler advent.ResultReturned, WeakAddressOf Advent_ResultReturned
		    advent.Start
		    
		    status = kLabelRunning
		    
		  elseif advent.ThreadState = Thread.ThreadStates.Paused then
		    advent.Resume
		    status = kLabelRunning
		    
		  else
		    advent.Pause
		    status = kLabelPaused
		    
		  end if
		  
		  me.CellTextAt( row, integer( Columns.Status ) ) = status
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  var row as integer = me.RowFromXY( x, y )
		  if row < 0 or row > me.LastRowIndex then
		    return false
		  end if
		  
		  var col as integer = me.ColumnFromXY( x, y )
		  if col = integer( Columns.Name ) then
		    var killMenu as new DesktopMenuItem( kMenuKill, row )
		    killMenu.Name = kMenuKill
		    
		    var advent as AdventBase = me.RowTagAt( row )
		    killMenu.Enabled = advent.ThreadState <> Thread.ThreadStates.NotRunning
		    
		    base.AddMenu killMenu
		    return true
		  end if
		  
		  if col < integer( Columns.ResultTestA ) or col > integer( columns.ResultB ) then
		    return false
		  end if
		  
		  var colText as string = me.CellTextAt( row, col )
		  if colText = "" then
		    return false
		  end if
		  
		  var rx as new RegEx
		  rx.SearchPattern = "^[^(]+"
		  var match as RegExMatch = rx.Search( colText )
		  if match isa RegExMatch then
		    colText = match.SubExpressionString( 0 )
		  end if
		  
		  var copyMenu as new DesktopMenuItem( "Copy " + colText, colText )
		  copyMenu.Name = kMenuCopy
		  base.AddMenu copyMenu
		  
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  select case selectedItem.Name
		  case kMenuCopy
		    var c as new Clipboard
		    c.Text = selectedItem.Tag.StringValue.Trim
		    c.Close
		    
		    return true
		    
		  case kMenuKill
		    var row as integer = selectedItem.Tag
		    var advent as AdventBase = me.RowTagAt( row )
		    
		    EndThread row, advent
		    
		  end select
		  
		End Function
	#tag EndEvent
	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  if me.RowExpandableAt( row ) and column = integer( Columns.Name ) then
		    g.Bold = true
		    return false
		  end if
		  
		  if column = integer( Columns.Name ) then
		    var advent as AdventBase = me.RowTagAt( row )
		    if advent.IsComplete then
		      g.DrawingColor = &c00AE0000
		    end if
		    
		    return false
		  end if
		  
		  if column < integer( Columns.ResultTestA ) then
		    return false
		  end if
		  
		  var colText as string = me.CellTextAt( row, column )
		  if colText = "" then
		    return false
		  end if
		  
		  var parts() as string = colText.Split( " (" )
		  colText = parts( 0 ).Trim
		  var duration as string = if( parts.Count = 2, parts( 1 ).Trim.Replace( ")", "" ), "" )
		  
		  g.Bold = true
		  g.DrawText colText, x, y
		  var colWidth as double = g.TextWidth( colText )
		  
		  static spaceWidth as double = g.TextWidth( " " )
		  
		  g.Bold = false
		  g.FontSize = 10
		  g.DrawingColor = Color.LightGray
		  g.DrawText duration, x + colWidth + spaceWidth + spaceWidth, y
		  
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub RowExpanded(row As Integer)
		  var objects() as AdventBase = me.RowTagAt( row )
		  for each advent as AdventBase in objects
		    var ti as Introspection.TypeInfo = Introspection.GetType( advent )
		    var name as string = ti.Name
		    name = name.Replace( "Advent_", "" )
		    name = name.ReplaceAll( "_", "-" )
		    name = name.Trim
		    
		    var puzzleName as string = advent.Name
		    if puzzleName <> "" then
		      name = name + " (" + puzzleName + ")"
		    end if
		    
		    me.AddRow name
		    me.RowTagAt( me.LastAddedRowIndex ) = advent
		    me.CellTooltipAt( me.LastAddedRowIndex, integer( Columns.Status ) ) = advent.Description
		  next
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Windows Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
