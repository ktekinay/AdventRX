#tag Class
Protected Class Set
	#tag Method, Flags = &h0
		Sub Constructor(input As String)
		  CaveDict = ParseJSON( "{}" )
		  
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  for each row as string in rows
		    var names() as string = row.Split( "-")
		    var c1 as Caves.Cave = LookupCave( names( 0 ).Trim )
		    var c2 as Caves.Cave = LookupCave( names( 1 ).Trim )
		    
		    c1.Add c2
		    c2.Add c1
		  next
		  
		  StartCave = CaveDict.Value( "start" )
		  EndCave = CaveDict.Value( "end" )
		  EndCave.IsEnd = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountPaths() As Integer
		  var visited as Dictionary = ParseJSON( "{}" )
		  return CountPaths( StartCave, visited )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountPaths(c As Caves.Cave, visited As Dictionary) As Integer
		  if c.IsEnd then
		    return 1
		  end if
		  
		  if c.IsSmall then
		    if visited.HasKey( c.Name ) then
		      return 0
		    end if
		    
		    visited.Value( c.Name ) = nil
		  end if
		  
		  var count as integer
		  
		  for each name as string in c.ConnectedNames
		    var nextCave as Caves.Cave = LookupCave( name )
		    count = count + CountPaths( nextCave, visited )
		  next
		  
		  if c.IsSmall then
		    visited.Remove( c.Name )
		  end if
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountPaths2() As Integer
		  var visited as Dictionary = ParseJSON( "{}" )
		  var visitedTwice as string
		  return CountPaths2( StartCave, visited, visitedTwice )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountPaths2(c As Caves.Cave, visited As Dictionary, ByRef visitedTwice As String) As Integer
		  if c.IsEnd then
		    return 1
		  end if
		  
		  if c.IsSmall then
		    if visited.HasKey( c.Name ) then
		      if visitedTwice <> "" or c.Name = "start" then
		        return 0
		      else
		        visitedTwice = c.Name
		      end if
		      
		    else
		      visited.Value( c.Name ) = nil
		    end if
		  end if
		  
		  var count as integer
		  
		  for each name as string in c.ConnectedNames
		    var nextCave as Caves.Cave = LookupCave( name )
		    count = count + CountPaths2( nextCave, visited, visitedTwice )
		  next
		  
		  if c.IsSmall then
		    if StrComp( visitedTwice, c.Name, 0 ) = 0 then
		      visitedTwice = ""
		    else
		      visited.Remove( c.Name )
		    end if
		  end if
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LookupCave(name As String) As Caves.Cave
		  var c as Caves.Cave = CaveDict.Lookup( name, nil )
		  if c is nil then
		    c = new Cave
		    c.Name = name
		    c.IsSmall = StrComp( name.Lowercase, name, 0 ) = 0
		    
		    CaveDict.Value( name ) = c
		  end if
		  
		  return c
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private CaveDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private EndCave As Caves.Cave
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StartCave As Cave
	#tag EndProperty


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
	#tag EndViewBehavior
End Class
#tag EndClass
