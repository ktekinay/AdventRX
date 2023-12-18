#tag Class
Protected Class Advent_2022_12_12
Inherits AdventBase
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Function ReturnDescription() As String
		  return "Find shortest path"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Hill Climbing Algorithm"
		  
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
		  var grid as new ObjectGrid
		  var startPos as TreeGridMember
		  var endPos as TreeGridMember
		  
		  ParseInput input, grid, startPos, endPos
		  
		  StartProfiling
		  var trail() as M_Path.MilestoneInterface = M_Path.FindPath( endPos, startPos ).Trail
		  StopProfiling
		  return trail.LastIndex : if( IsTest, 31, 520 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  StartProfiling
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  static ascA as integer = asc( "a" )
		  
		  var grid as ObjectGrid
		  var startPos as TreeGridMember
		  var endPos as TreeGridMember
		  
		  grid = new ObjectGrid
		  ParseInput input, grid, startPos, endPos
		  
		  var aList as new Set
		  
		  for each member as TreeGridMember in grid
		    if member.Value = ascA then
		      aList.Add member
		    end if
		  next
		  
		  var finder as new PathFinder_MTC( endPos )
		  
		  //
		  // Prime the pump
		  //
		  var best as integer = finder.Map( startPos ).Trail.LastIndex
		  aList.Remove startPos
		  
		  while aList.Count <> 0
		    startPos = aList.Pop
		    
		    var result as M_Path.Result = finder.Map( startPos )
		    var trail() as M_Path.MilestoneInterface = result.Trail
		    
		    if trail.Count = 0 then
		      for each v as variant in result.Touched.Keys
		        if aList.HasMember( v ) then aList.Remove( v )
		      next
		      
		    else
		      if trail.LastIndex < best then
		        best = trail.LastIndex
		      end if
		      
		      var lastAIndex as integer
		      
		      for i as integer = 1 to trail.LastIndex
		        var t as TreeGridMember = TreeGridMember( trail( i ) )
		        
		        if t.Value = ascA then
		          lastAIndex = i
		          
		          if aList.HasMember( t ) then
		            aList.Remove t
		          end if
		        end if
		      next
		      
		      best = if( best < ( trail.LastIndex - lastAIndex ), best,  trail.LastIndex - lastAIndex )
		    end if
		  wend
		  
		  StopProfiling
		  
		  best = best
		  return best : if( IsTest, 29, 508 )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseInput(input As String, grid As ObjectGrid, ByRef startPos As TreeGridMember, ByRef endPos As TreeGridMember)
		  var sarr( -1, -1 ) as string = ToStringGrid( input )
		  
		  grid.ResizeTo sarr.LastIndex( 1 ), sarr.LastIndex( 2 )
		  
		  for row as integer = 0 to grid.LastRowIndex
		    for col as integer = 0 to grid.LastColIndex
		      var member as new TreeGridMember
		      member.PrintType = GridMember.PrintTypes.UseRawValue
		      
		      var sValue as string = sarr( row, col )
		      
		      if sValue.Compare( "S", ComparisonOptions.CaseSensitive ) = 0 then
		        sValue = "a"
		        startPos = member
		      elseif sValue.Compare( "E", ComparisonOptions.CaseSensitive ) = 0 then
		        sValue = "z"
		        endPos = member
		      end if
		      
		      var value as integer = sValue.Asc
		      
		      member.RawValue = sValue
		      member.Value = value
		      member.BestSteps = 0
		      grid( row, col ) = member
		    next
		  next
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"Sabqponm\nabcryxxl\naccszExk\nacctuvwj\nabdefghi", Scope = Private
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
