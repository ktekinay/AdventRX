#tag Class
Protected Class Advent_2022_12_07
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Walk disk directory"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "No Space Left On Device"
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( Normalize( GetPuzzleInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( Normalize( GetPuzzleInput ) )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Integer
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var root as MockFolderItem = InputToRoot( input )
		  
		  return Walk( root, 100000 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var root as MockFolderItem = InputToRoot( input )
		  
		  var used as integer = root.Size
		  var totalDiskSpace as integer = 70000000
		  var available as integer = totalDiskSpace - used
		  var target as integer = 30000000
		  var toFree as integer = target - available
		  
		  var minimum as integer = totalDiskSpace
		  MinOverTarget root, toFree, minimum
		  
		  return minimum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InputToRoot(input As String) As MockFolderItem
		  var lines() as string = ToStringArray( input )
		  
		  var root as new MockFolderItem
		  root.IsDirectory = true
		  
		  var current as MockFolderItem = root
		  
		  for each line as string in lines
		    if line.BeginsWith( "$ cd " ) then
		      var dir as string = line.Middle( 5 )
		      if dir = "/" then
		        current = root
		      elseif dir = ".." then
		        current = current.Parent
		      else
		        var nextDir as MockFolderItem = current.Child( dir )
		        if nextDir is nil then
		          nextDir = new MockFolderItem
		          nextDir.Name = dir
		          nextDir.IsDirectory = true
		          current.AddChild nextDir
		        end if
		        
		        current = nextDir
		      end if
		      
		      continue
		    end if
		    
		    if line = "$ ls" then
		      continue
		    end if
		    
		    if line.BeginsWith( "dir" ) then
		      var child as new MockFolderItem
		      child.Name = line.Middle( 4 )
		      child.IsDirectory = true
		      current.AddChild child
		      
		      continue
		    end if
		    
		    //
		    // File
		    //
		    var parts() as string = line.Split( " " )
		    var child as new MockFolderItem
		    child.Name = parts( 1 )
		    child.Size = parts( 0 ).ToInteger
		    current.AddChild child
		  next
		  
		  root.UpdateSize
		  return root
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MinOverTarget(f As MockFolderItem, target As Integer, ByRef currentMin As Integer)
		  if not f.IsDirectory then
		    return
		  end if
		  
		  if f.Size >= target and f.Size < currentMin then
		    currentMin = f.Size
		  end if
		  
		  for each child as MockFolderItem in f.Files
		    MinOverTarget child, target, currentMin
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Walk(f As MockFolderItem, threshold As Integer) As Integer
		  if not f.IsDirectory then
		    return 0
		  end if
		  
		  var size as integer
		  
		  if f.Size <= threshold then
		    size = size + f.Size
		  end if
		  
		  for each child as MockFolderItem in f.Files
		    size = size + Walk( child, threshold )
		  next
		  
		  return size
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
