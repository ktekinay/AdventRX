#tag Class
Class ObjectGrid
Implements Iterable
	#tag Method, Flags = &h0
		Function Above(member As GridMember) As GridMember
		  if member.Row = 0 then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveLeft(member As GridMember) As GridMember
		  if member.Row = 0 or member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveLeftWrapping(member As GridMember) As GridMember
		  var useRow as integer = member.Row - 1
		  var useColumn as integer = member.Column - 1
		  
		  if useRow < 0 then
		    useRow = LastRowIndex
		  end if
		  
		  if useColumn < 0 then
		    useColumn = LastColIndex
		  end if
		  
		  return Grid( useRow, useColumn )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveRight(member As GridMember) As GridMember
		  if member.Row = 0 or member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row - 1, member.Column + 1 )
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveRightWrapping(member As GridMember) As GridMember
		  var useRow as integer = member.Row - 1
		  var useColumn as integer = member.Column + 1
		  
		  if useRow < 0 then
		    useRow = LastRowIndex
		  end if
		  if useColumn > LastColIndex then
		    useColumn = 0
		  end if
		  
		  return Grid( useRow, useColumn )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AboveWrapping(member As GridMember) As GridMember
		  if member.Row = 0 then
		    return Grid( LastRowIndex, member.Column )
		  else
		    return Grid( member.Row - 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllDirectionals() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate = MainDirectionals
		  
		  directionals.Add AddressOf AboveLeft
		  directionals.Add AddressOf AboveRight
		  directionals.Add AddressOf BelowLeft
		  directionals.Add AddressOf BelowRight
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AllDirectionalsWrapping() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate = MainDirectionalsWrapping
		  
		  directionals.Add AddressOf AboveLeftWrapping
		  directionals.Add AddressOf AboveRightWrapping
		  directionals.Add AddressOf BelowLeftWrapping
		  directionals.Add AddressOf BelowRightWrapping
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Below(member As GridMember) As GridMember
		  if member.Row = LastRowIndex then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowLeft(member As GridMember) As GridMember
		  if member.Row = LastRowIndex or member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowLeftWrapping(member As GridMember) As GridMember
		  var useRow as integer = member.Row + 1
		  var useColumn as integer = member.Column - 1
		  
		  if useRow > LastRowIndex then
		    useRow = 0
		  end if
		  
		  if useColumn < 0 then
		    useColumn = LastColIndex
		  end if
		  
		  return Grid( useRow, useColumn )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowRight(member As GridMember) As GridMember
		  if member.Row = LastRowIndex or member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row + 1, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowRightWrapping(member As GridMember) As GridMember
		  var useRow as integer = member.Row + 1
		  var useColumn as integer = member.Column + 1
		  
		  if useRow > LastRowIndex then
		    useRow = 0
		  end if
		  
		  if useColumn > LastColIndex then
		    useColumn = 0
		  end if
		  
		  return Grid( useRow, useColumn )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BelowWrapping(member As GridMember) As GridMember
		  if member.Row = LastRowIndex then
		    return Grid( 0, member.Column )
		  else
		    return Grid( member.Row + 1, member.Column )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E6420746865206265737420706174682066726F6D2073746172744D656D62657220746F20656E644D656D626572207573696E672064697374616E636544656C656761746520746F2064657465726D696E65207468652064697374616E6365206F72206566666F72742E20556E726561636861626C65206E65696768626F72732077696C6C2062652072656D6F7665642066726F6D2065616368206D656D6265722773204E65696768626F72732061727261792E
		Attributes( Deprecated = "PathFinder_MTC" )  Function BestPath(startMember As GridMember, endMember As GridMember, distanceDelegate As PathDistanceDelegate, includeDiagonals As Boolean) As GridMember()
		  var currentTrail() as GridMember
		  var trail() as GridMember
		  
		  Traverse endMember, startMember, distanceDelegate, includeDiagonals, new Dictionary, currentTrail, trail, 1
		  
		  return trail
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  for each m as GridMember in self
		    if m isa object then
		      m.Teardown
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromIntegerGrid(igrid(, ) As Integer) As ObjectGrid
		  var lastRowIndex as integer = igrid.LastIndex( 1 )
		  var lastColIndex as integer = igrid.LastIndex( 2 )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0  to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      grid( row, col ) = new GridMember( igrid( row, col ) )
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromStringGrid(sgrid(, ) As String, template As GridMember = Nil) As ObjectGrid
		  var templateConstructor as Introspection.ConstructorInfo
		  
		  if template isa object then
		    var ti as Introspection.TypeInfo = Introspection.GetType( template )
		    for each c as Introspection.ConstructorInfo in ti.GetConstructors
		      var params() as Introspection.ParameterInfo = c.GetParameters
		      if params.Count <> 1 then
		        continue for c
		      end if
		      var param as Introspection.ParameterInfo = params( 0 )
		      if param.ParameterType.Name = "Variant" then
		        templateConstructor = c
		        exit for c
		      end if
		    next
		    
		    if templateConstructor is nil then
		      raise new RuntimeException( "Could not locate Constructor" )
		    end if
		  end if
		  
		  var lastRowIndex as integer = sgrid.LastIndex( 1 )
		  var lastColIndex as integer = sgrid.LastIndex( 2 )
		  
		  var grid as new ObjectGrid
		  grid.ResizeTo lastRowIndex, lastColIndex
		  
		  for row as integer = 0  to lastRowIndex
		    for col as integer = 0 to lastColIndex
		      var value as variant = sgrid( row, col )
		      if template isa object then
		        var values() as variant
		        values.Add value
		        grid( row, col ) = templateConstructor.Invoke( values )
		      else
		        grid( row, col ) = new GridMember( sgrid( row, col ) )
		      end if
		    next
		  next
		  
		  return grid
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertColumnAt(beforeColumn As Integer)
		  if beforeColumn < 0 or beforeColumn > LastColIndex + 1 then
		    raise new OutOfBoundsException
		  end if
		  
		  ResizeTo LastRowIndex, LastColIndex + 1
		  
		  for row as integer = 0 to LastRowIndex
		    for col as integer = LastColIndex - 1 downto beforeColumn
		      var gm as GridMember = Grid( row, col )
		      Operator_Subscript( row, col + 1 ) = gm
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertRowAt(beforeRow As Integer)
		  if beforeRow < 0 or beforeRow > LastRowIndex + 1 then
		    raise new OutOfBoundsException
		  end if
		  
		  ResizeTo LastRowIndex + 1, LastColIndex
		  
		  for row as integer = LastRowIndex - 1 downto beforeRow
		    for col as integer = 0 to LastColIndex
		      var gm as GridMember = Grid( row, col )
		      Operator_Subscript( row + 1, col ) = gm
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  return new ObjectGridIterator( Grid )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(member As GridMember) As GridMember
		  if member.Column = 0 then
		    return nil
		  else
		    return Grid( member.Row, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeftWrapping(member As GridMember) As GridMember
		  if member.Column = 0 then
		    return Grid( member.Row, LastColIndex )
		  else
		    return Grid( member.Row, member.Column - 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainDirectionals() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate
		  directionals.Add AddressOf Above
		  directionals.Add AddressOf Right
		  directionals.Add AddressOf Below
		  directionals.Add AddressOf Left
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MainDirectionalsWrapping() As ObjectGrid.NextDelegate()
		  var directionals() as ObjectGrid.NextDelegate
		  directionals.Add AddressOf AboveWrapping
		  directionals.Add AddressOf RightWrapping
		  directionals.Add AddressOf BelowWrapping
		  directionals.Add AddressOf LeftWrapping
		  
		  return directionals
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function NextDelegate(member As GridMember) As GridMember
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  var rowBuilder() as string
		  for row as integer = 0 to mLastRowIndex
		    var colBuilder() as string
		    for col as integer = 0 to mLastColIndex
		      var m as GridMember = Grid( row, col )
		      if m is nil then
		        'colBuilder.Add &uFF0E
		        colBuilder.Add "."
		      else
		        colBuilder.Add Grid( row, col ).ToString
		      end if
		    next
		    rowBuilder.Add String.FromArray( colBuilder, "" )
		  next
		  
		  return String.FromArray( rowBuilder, EndOfLine )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(row As Integer, col As Integer) As GridMember
		  return Grid( row, col )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(row As Integer, col As Integer, Assigns m As GridMember)
		  Grid( row, col ) = m
		  if m isa object then
		    m.Grid = self
		    m.Row = row
		    m.Column = col
		  end if
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0, Description = 5768656E2074726176657273696E67206120706174682C2072657475726E73207468652064697374616E6365206F72206566666F7274206E656564656420746F20726561636820746F4D656D6265722066726F6D2066726F6D4D656D6265722C206F7220302069662069742063616E27742072656163682069742E
		Delegate Function PathDistanceDelegate(fromMember As GridMember, toMember As GridMember) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub ResizeTo(row As Integer, col As Integer)
		  mLastRowIndex = row
		  mLastColIndex = col
		  
		  Grid.ResizeTo row, col
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(member As GridMember) As GridMember
		  if member.Column = LastColIndex then
		    return nil
		  else
		    return Grid( member.Row, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RightWrapping(member As GridMember) As GridMember
		  if member.Column = LastColIndex then
		    return Grid( member.Row, 0 )
		  else
		    return Grid( member.Row, member.Column + 1 )
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Traverse(currentPos As GridMember, startPos As GridMember, distanceDelegate As PathDistanceDelegate, includeDiagonals As Boolean, visited As Dictionary, currentTrail() As GridMember, ultimateTrail() As GridMember, depth As Integer)
		  if visited.HasKey( currentPos ) or currentPos is startPos then
		    return
		  end if
		  
		  if startPos.BestSteps > 0 and startPos.BestSteps <= currentPos.BestSteps then
		    //
		    // No need to go further down this road
		    //
		    return
		  end if
		  
		  visited.Value( currentPos ) = nil
		  
		  var neighbors() as GridMember = currentPos.Neighbors( includeDiagonals )
		  
		  currentTrail.Add currentPos
		  
		  for index as integer = neighbors.LastIndex downto 0
		    var neighbor as GridMember = neighbors( index )
		    
		    var steps as integer = distanceDelegate.Invoke( neighbor, currentPos )
		    if steps <= 0 then
		      //
		      // Can't reach this
		      //
		      neighbors.RemoveAt index // No need to test this again
		      continue
		    end if
		    
		    steps = steps + currentPos.BestSteps
		    
		    if neighbor.BestSteps > 0 and neighbor.BestSteps <= steps then
		      //
		      // Already found a better path
		      //
		      continue
		    end if
		    
		    neighbor.BestSteps = steps
		    
		    //
		    // Have we found the start?
		    //
		    if neighbor is startPos then
		      ultimateTrail.RemoveAll
		      
		      ultimateTrail.Add neighbor
		      for i as integer = currentTrail.LastIndex downto 0
		        ultimateTrail.Add currentTrail( i )
		      next
		      
		    else
		      Traverse neighbor, startPos, distanceDelegate, includeDiagonals, visited, currentTrail, ultimateTrail, depth + 1
		      
		    end if
		  next
		  
		  call currentTrail.Pop
		  
		  visited.Remove currentPos
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Grid(-1,-1) As GridMember
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if not DebugBuild
			    #pragma BoundsChecking false
			    #pragma NilObjectChecking false
			    #pragma StackOverflowChecking false
			  #endif
			  
			  Return mLastColIndex
			End Get
		#tag EndGetter
		LastColIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #if not DebugBuild
			    #pragma BoundsChecking false
			    #pragma NilObjectChecking false
			    #pragma StackOverflowChecking false
			  #endif
			  
			  Return mLastRowIndex
			End Get
		#tag EndGetter
		LastRowIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLastColIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWeakRef As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return self
			  
			End Get
		#tag EndGetter
		ToString As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mWeakRef is nil then
			    mWeakRef = new WeakRef( self )
			  end if
			  
			  return mWeakRef
			  
			End Get
		#tag EndGetter
		WeakRef As WeakRef
	#tag EndComputedProperty


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
			Name="LastColIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToString"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
