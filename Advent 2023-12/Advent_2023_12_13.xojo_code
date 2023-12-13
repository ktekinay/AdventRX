#tag Class
Protected Class Advent_2023_12_13
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Find reflections"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Point of Incidence"
		  
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
		  var result as integer
		  
		  var sections() as string = input.SplitBytes( &uA + &uA )
		  
		  for each section as string in sections
		    var grid( -1, -1 ) as string = ToStringGrid( section )
		    
		    var count as integer = VerticalReflection( grid )
		    if count <> -1 then
		      result = result + ( count * 100 )
		      continue for section
		    end if
		    
		    result = result + HorizontalReflection( grid )
		  next
		  
		  return result : if( IsTest, 405, 27505 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var result as integer
		  
		  var sections() as string = input.SplitBytes( &uA + &uA )
		  
		  for sectionIndex as integer = 0 to sections.LastIndex
		    var section as string = sections( sectionIndex )
		    
		    var grid( -1, -1 ) as string = ToStringGrid( section )
		    
		    var hOrigCount as integer = HorizontalReflection( grid )
		    var vOrigCount as integer = VerticalReflection( grid )
		    
		    var lastRowIndex as integer = grid.LastIndex( 1 )
		    var lastColIndex as integer = grid.LastIndex( 2 )
		    
		    for row as integer = 0 to lastRowIndex
		      for col as integer = 0 to lastColIndex
		        var orig as string = grid( row, col )
		        if orig = "#" then
		          grid( row, col ) = "."
		        else
		          grid( row, col ) = "#"
		        end if
		        
		        var hCount as integer = HorizontalReflection( grid, hOrigCount )
		        if hCount <> -1 then
		          result = result + hCount
		          continue for sectionIndex
		        end if
		        
		        var vCount as integer = VerticalReflection( grid, vOrigCount )
		        if vCount <> -1 then
		          result = result + ( vCount * 100 )
		          continue for sectionIndex
		        end if
		        
		        grid( row, col ) = orig
		      next col
		    next row
		  next sectionIndex
		  
		  return result : if( IsTest, 400, 22906 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HorizontalReflection(grid(, ) As String, ignore As Integer = -1) As Integer
		  var lastColIndex as integer = grid.LastIndex( 2 )
		  
		  var cols() as string
		  for col as integer = 0 to lastColIndex
		    cols.Add grid.Column( col ).ToString
		  next
		  
		  for checkCol as integer = 1 to cols.LastIndex
		    if checkCol = ignore then
		      continue
		    end if
		    
		    var rightCol as integer = checkCol
		    var leftCol as integer = checkCol - 1
		    
		    while leftCol >= 0 and rightCol <= cols.LastIndex
		      if cols( leftCol ) <> cols( rightCol ) then
		        continue for checkCol
		      end if
		      
		      leftCol = leftCol - 1
		      rightCol = rightCol + 1
		    wend
		    
		    return checkCol
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function VerticalReflection(grid(, ) As String, ignore As Integer = -1) As Integer
		  var lastRowIndex as integer = grid.LastIndex( 1 )
		  
		  var rows() as string
		  for row as integer = 0 to lastRowIndex
		    rows.Add grid.Row( row ).ToString
		  next
		  
		  for checkRow as integer = 1 to rows.LastIndex
		    if checkRow = ignore then
		      continue
		    end if
		    
		    var bottomRow as integer = checkRow
		    var topRow as integer = checkRow - 1
		    
		    while topRow >= 0 and bottomRow <= rows.LastIndex
		      if rows( topRow ) <> rows( bottomRow ) then
		        continue for checkRow
		      end if
		      
		      topRow = topRow - 1
		      bottomRow = bottomRow + 1
		    wend
		    
		    return checkRow
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"#.##..##.\n..#.##.#.\n##......#\n##......#\n..#.##.#.\n..##..##.\n#.#.##.#.\n\n#...##..#\n#....#..#\n..##..###\n#####.##.\n#####.##.\n..##..###\n#....#..#", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInputB, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


	#tag Using, Name = M_2023
	#tag EndUsing


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
