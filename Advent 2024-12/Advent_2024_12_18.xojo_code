#tag Class
Protected Class Advent_2024_12_18
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find best path through falling RAM"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "RAM Run"
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
		  return CalculateResultA( Normalize( kTestInput ) )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  var input as string = kTestInputB
		  if input = "" then
		    input = kTestInput
		  end if
		  
		  return CalculateResultB( Normalize( input ) )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Variant
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  if IsTest then
		    rows.ResizeTo 11
		  else
		    rows.ResizeTo 1023
		  end if
		  
		  var sgrid( -1, -1 ) as string = MakeGrid( IsTest )
		  
		  var lastRowIndex as integer = sgrid.LastIndex( 1 )
		  var lastColIndex as integer = sgrid.LastIndex( 2 )
		  
		  for each coords as string in rows
		    var parts() as string = coords.Split( "," )
		    
		    var x as integer = parts( 0 ).ToInteger
		    var y as integer = parts( 1 ).ToInteger
		    
		    sgrid( y, x ) = "#"
		  next
		  
		  var grid as Advent.ObjectGrid = Advent.ObjectGrid.FromStringGrid( sgrid, new MemorySpace )
		  var goal as M_Path.MilestoneInterface = M_Path.MilestoneInterface( grid( lastRowIndex, lastColIndex ) )
		  var start as M_Path.MilestoneInterface = M_Path.MilestoneInterface( grid( 0, 0 ) )
		  
		  var result as M_Path.Result = M_Path.FindPath( goal, start )
		  
		  return result.Trail.LastIndex : if( IsTest, 22, 284 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var rows() as string = Normalize( input ).Split( EndOfLine )
		  
		  var sgrid( -1, -1 ) as string = MakeGrid( IsTest )
		  
		  var lastRowIndex as integer = sgrid.LastIndex( 1 )
		  var lastColIndex as integer = sgrid.LastIndex( 2 )
		  
		  var grid as Advent.ObjectGrid = Advent.ObjectGrid.FromStringGrid( sgrid, new MemorySpace )
		  var goal as M_Path.MilestoneInterface = M_Path.MilestoneInterface( grid( lastRowIndex, lastColIndex ) )
		  var start as M_Path.MilestoneInterface = M_Path.MilestoneInterface( grid( 0, 0 ) )
		  
		  var badCoords as string
		  var lastTrail as new Set
		  var result as M_Path.Result
		  
		  for rowIndex as integer = 0 to rows.LastIndex
		    var coords as string = rows( rowIndex )
		    
		    var parts() as string = coords.Split( "," )
		    
		    var x as integer = parts( 0 ).ToInteger
		    var y as integer = parts( 1 ).ToInteger
		    
		    var sq as new MemorySpace( "#" )
		    grid( y, x ) = sq
		    
		    if IsTest and rowIndex < 11 then
		      continue
		    elseif not IsTest and rowIndex < 1023 then
		      continue
		    end if
		    
		    if lastTrail.Count = 0 or lastTrail.HasMember( sq.GetKey ) then
		      result = M_Path.FindPath( goal, start, true )
		      
		      if result.Trail.Count = 0 then
		        badCoords = coords
		        exit
		      end if
		      
		      lastTrail.RemoveAll
		      
		      for each mi as M_Path.MilestoneInterface in result.Trail
		        lastTrail.Add( mi.GetKey )
		      next
		    end if
		  next
		  
		  return badCoords : if( IsTest, "6,1", "51,50" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MakeGrid(isTest As Boolean) As String(,)
		  var sgrid( -1, -1 ) as String
		  
		  if isTest then
		    sgrid.ResizeTo 6, 6
		  else
		    sgrid.ResizeTo 70, 70
		  end if
		  
		  var lastRowIndex as integer = sgrid.LastIndex( 1 )
		  var lastColIndex as integer = sgrid.LastIndex( 2 )
		  
		  for row as integer = 0 to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      sgrid( row, col ) = "."
		    next
		  next
		  
		  return sgrid
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"5\x2C4\n4\x2C2\n4\x2C5\n3\x2C0\n2\x2C1\n6\x2C3\n2\x2C4\n1\x2C5\n0\x2C6\n3\x2C3\n2\x2C6\n5\x2C1\n1\x2C2\n5\x2C5\n2\x2C5\n6\x2C5\n1\x2C4\n0\x2C4\n6\x2C4\n1\x2C1\n6\x2C1\n1\x2C0\n0\x2C5\n1\x2C6\n2\x2C0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2024
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
