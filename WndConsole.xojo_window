#tag DesktopWindow
Begin DesktopWindow WndConsole
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   True
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   576
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   ""
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Console"
   Type            =   0
   Visible         =   True
   Width           =   906
   Begin DesktopTextArea FldConsole
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "0xProto Nerd Font Mono"
      FontSize        =   13.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   546
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   906
   End
   Begin Timer TmrPrinter
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin DesktopCheckBox CbKeepPinned
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Keep Pinned"
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   786
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   549
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   1
      Width           =   100
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  IsOpen = false
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  return HandleKeyDown( key )
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  IsOpen = true
		  BaseFontSize = FldConsole.FontSize
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function HandleKeyDown(key As String) As Boolean
		  if not Keyboard.CommandKey then
		    return false
		  end if
		  
		  if key = "+" or key = "=" then
		    FldConsole.FontSize = FldConsole.FontSize + 2
		    return true
		  elseif key = "-" and FldConsole.FontSize > BaseFontSize then
		    FldConsole.FontSize = FldConsole.FontSize - 2
		    return true
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Print(msg As String)
		  Messages.Add msg
		  Timer.CallLater 1,  AddressOf ShowAsNeeded
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ShowAsNeeded()
		  if not IsOpen then
		    WndConsole.Show
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private BaseFontSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared IsOpen As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared Messages() As String
	#tag EndProperty


#tag EndWindowCode

#tag Events FldConsole
	#tag Event
		Function KeyDown(key As String) As Boolean
		  return HandleKeyDown( key )
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TmrPrinter
	#tag Event
		Sub Action()
		  if Messages.Count <> 0 then
		    var toPrint as string = String.FromArray( Messages, EndOfLine )
		    Messages.RemoveAll
		    
		    FldConsole.AddText toPrint + EndOfLine
		    
		    if CbKeepPinned.Value then
		      FldConsole.VerticalScrollPosition = FldConsole.LineNumber( FldConsole.Text.Bytes * 4 )
		    end if
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CbKeepPinned
	#tag Event
		Sub Opening()
		  me.Value = true
		  
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
			"9 - Modeless Dialog"
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
