#tag Class
Protected Class Advent_2022_12_23
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Move the elves"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "Unstable Diffusion"
		  
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
		Private Sub ApplyInstructions(elf As ElfGridMember, instructions() As ElfInstruction)
		  elf.ProposedMove = nil
		  
		  var hasNeighbor as boolean
		  
		  for each direction as ObjectGrid.NextDelegate in elf.Grid.AllDirectionals
		    if direction.Invoke( elf ) isa object then
		      hasNeighbor = true
		      exit
		    end if
		  next
		  
		  if not hasNeighbor then
		    return
		  end if
		  
		  for each instruction as ElfInstruction in instructions
		    for each consider as ObjectGrid.NextDelegate in instruction.Consider
		      if consider.Invoke( elf ) isa object then
		        continue for instruction
		      end if
		    next
		    
		    var pt as new Xojo.Point( elf.Column + instruction.ColDelta, elf.Row + instruction.RowDelta )
		    elf.ProposedMove = pt
		    return
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  const kRounds as integer = 10
		  
		  var grid as ObjectGrid = ParseInput( input, kRounds )
		  
		  var elves() as ElfGridMember
		  for each member as ElfGridMember in grid
		    if member isa ElfGridMember then
		      elves.Add member
		    end if
		  next
		  
		  var instructions() as ElfInstruction = GetInstructions( grid )
		  
		  'if IsTest then
		  'Print grid
		  'Print ""
		  'end if
		  
		  for round as integer = 1 to kRounds
		    var moveToDict as new Dictionary
		    
		    for each elf as ElfGridMember in elves
		      ApplyInstructions elf, instructions
		      
		      if elf.ProposedMove isa object then
		        var moveKey as variant = elf.ProposedMove.ToKey
		        if moveToDict.HasKey( moveKey ) then
		          elf.ProposedMove = nil
		          
		          var movingElf as ElfGridMember = moveToDict.Value( moveKey )
		          if movingElf isa object then
		            movingElf.ProposedMove = nil
		            moveToDict.Value( moveKey ) = nil
		          end if
		          
		        else
		          moveToDict.Value( elf.ProposedMove.ToKey ) = elf
		        end if
		      end if
		    next
		    
		    for each elf as ElfGridMember in elves
		      if elf.ProposedMove isa object then
		        elf.Row = elf.ProposedMove.Y
		        elf.Column = elf.ProposedMove.X
		      end if
		    next
		    
		    var lastRowIndex as integer = grid.LastRowIndex
		    var lastColIndex as integer = grid.LastColIndex
		    grid.ResizeTo -1, -1
		    grid.ResizeTo lastRowIndex, lastcolIndex
		    
		    for each elf as ElfGridMember in elves
		      grid( elf.Row, elf.Column ) = elf
		    next
		    
		    instructions.Add instructions( 0 )
		    instructions.RemoveAt 0
		    
		    'if IsTest then
		    'Print grid
		    'Print ""
		    'end if
		  next
		  
		  var minRow, minCol, maxRow, maxCol as integer
		  minRow = elves( 0 ).Row
		  maxRow = minRow
		  minCol = elves( 0 ).Column
		  maxCol = minCol
		  
		  for each elf as ElfGridMember in elves
		    minRow = min( minRow, elf.Row )
		    maxRow = max( maxRow, elf.Row )
		    minCol = min( minCol, elf.Column )
		    maxCol = max( maxCol, elf.Column )
		  next
		  
		  var count as integer
		  for row as integer = minRow to maxRow
		    for col as integer = minCol to maxCol
		      if grid( row, col ) is nil then
		        count = count + 1
		      end if
		    next
		  next
		  
		  return count
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  const kRounds as integer = 1000
		  
		  var grid as ObjectGrid = ParseInput( input, kRounds )
		  
		  var elves() as ElfGridMember
		  for each member as ElfGridMember in grid
		    if member isa ElfGridMember then
		      elves.Add member
		    end if
		  next
		  
		  var instructions() as ElfInstruction = GetInstructions( grid )
		  
		  'if IsTest then
		  'Print grid
		  'Print ""
		  'end if
		  
		  for round as integer = 1 to kRounds
		    var moveToDict as new Dictionary
		    
		    for each elf as ElfGridMember in elves
		      ApplyInstructions elf, instructions
		      
		      if elf.ProposedMove isa object then
		        var moveKey as variant = elf.ProposedMove.ToKey
		        if moveToDict.HasKey( moveKey ) then
		          elf.ProposedMove = nil
		          
		          var movingElf as ElfGridMember = moveToDict.Value( moveKey )
		          if movingElf isa object then
		            movingElf.ProposedMove = nil
		            moveToDict.Value( moveKey ) = nil
		          end if
		          
		        else
		          moveToDict.Value( elf.ProposedMove.ToKey ) = elf
		        end if
		      end if
		    next
		    
		    var countProposed as integer
		    for each elf as ElfGridMember in elves
		      if elf.ProposedMove isa object then
		        elf.Row = elf.ProposedMove.Y
		        elf.Column = elf.ProposedMove.X
		        countProposed = countProposed + 1
		      end if
		    next
		    
		    if countProposed = 0 then
		      return round
		    end if
		    
		    var lastRowIndex as integer = grid.LastRowIndex
		    var lastColIndex as integer = grid.LastColIndex
		    grid.ResizeTo -1, -1
		    grid.ResizeTo lastRowIndex, lastcolIndex
		    
		    for each elf as ElfGridMember in elves
		      grid( elf.Row, elf.Column ) = elf
		    next
		    
		    instructions.Add instructions( 0 )
		    instructions.RemoveAt 0
		    
		    'if IsTest then
		    'Print grid
		    'Print ""
		    'end if
		  next
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetInstructions(grid As Advent.ObjectGrid) As ElfInstruction()
		  var result() as ElfInstruction
		  
		  var ins as ElfInstruction
		  
		  //
		  // North
		  //
		  ins = new ElfInstruction
		  ins.Name = "North"
		  ins.Consider.Add WeakAddressOf grid.AboveLeft
		  ins.Consider.Add WeakAddressOf grid.Above
		  ins.Consider.Add WeakAddressOf grid.AboveRight
		  ins.RowDelta = -1
		  result.Add ins
		  
		  //
		  // South
		  //
		  ins = new ElfInstruction
		  ins.Name = "South"
		  ins.Consider.Add WeakAddressOf grid.BelowLeft
		  ins.Consider.Add WeakAddressOf grid.Below
		  ins.Consider.Add WeakAddressOf grid.BelowRight
		  ins.RowDelta = 1
		  result.Add ins
		  
		  //
		  // West
		  //
		  ins = new ElfInstruction
		  ins.Name = "West"
		  ins.Consider.Add WeakAddressOf grid.AboveLeft
		  ins.Consider.Add WeakAddressOf grid.Left
		  ins.Consider.Add WeakAddressOf grid.BelowLeft
		  ins.ColDelta = -1
		  result.Add ins
		  
		  //
		  // East
		  //
		  ins = new ElfInstruction
		  ins.Name = "East"
		  ins.Consider.Add WeakAddressOf grid.AboveRight
		  ins.Consider.Add WeakAddressOf grid.Right
		  ins.Consider.Add WeakAddressOf grid.BelowRight
		  ins.ColDelta = 1
		  result.Add ins
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String, rounds As Integer) As ObjectGrid
		  var sgrid( -1, -1 ) as string = ToStringGrid( input )
		  
		  var lastRowIndex as integer = sgrid.LastIndex( 1 ) + rounds + rounds
		  var lastColIndex as integer = sgrid.LastIndex( 2 ) + rounds + rounds
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0 to sgrid.LastIndex( 1 )
		    for col as integer = 0 to sgrid.LastIndex( 2 )
		      if sgrid( row, col ) = "#" then
		        var elf as new ElfGridMember( "#" )
		        grid( row + rounds, col + rounds ) = elf
		      end if
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"....#..\n..###.#\n#...#.#\n.#...##\n#.###..\n##.#.##\n.#..#..", Scope = Private
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
