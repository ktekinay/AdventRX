#tag Class
Protected Class Advent_2015_12_09
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Shortest and longest routes"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "All in a Single Night"
		  
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
		Private Sub AddDistance(dict As Dictionary, city1 As String, city2 As String, distance As Integer)
		  var cityDict as Dictionary = dict.Lookup( city1, nil )
		  
		  if cityDict is nil then
		    cityDict = new Dictionary
		    dict.Value( city1 ) = cityDict
		  end if
		  
		  cityDict.Value( city2 ) = distance
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  if IsTest then
		    return -1
		  end if
		  
		  var arr() as string = ToStringArray( input )
		  
		  var distances as new Dictionary
		  var minimum as integer
		  
		  for each line as string in arr
		    var parts() as string = line.Split( " " )
		    
		    var city1 as string = parts( 0 )
		    var city2 as string = parts( 2 )
		    var distance as integer = parts( 4 ).ToInteger
		    
		    AddDistance distances, city1, city2, distance
		    AddDistance distances, city2, city1, distance
		    
		    minimum = minimum + distance
		  next
		  
		  var cities() as string
		  
		  for each key as variant in distances.Keys
		    cities.Add key
		  next
		  
		  GetMinimum( cities, "", distances, 0, minimum )
		  
		  self.Distances = Distances
		  self.Cities = cities
		  
		  return minimum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  if IsTest then
		    return -1
		  end if
		  
		  var maximum as integer
		  GetMaximum Cities, "", Distances, 0, maximum
		  return maximum
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetDistance(distances As Dictionary, fromCity As String, toCity As String) As Integer
		  if fromCity = "" or toCity = "" then
		    return 0
		  end if
		  
		  var cityDict as Dictionary = distances.Value( fromCity )
		  return cityDict.Value( toCity ).IntegerValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetMaximum(cities() As String, fromCity As string, distances As Dictionary, currentDistance As Integer, ByRef currentMax As Integer)
		  if cities.Count = 0 then
		    currentMax = max( currentMax, currentDistance )
		    return
		  end if
		  
		  for i as integer = 0 to cities.LastIndex
		    var toCity as string = cities( i )
		    cities.RemoveAt i
		    
		    var distance as integer = GetDistance( distances, fromCity, toCity )
		    
		    GetMaximum cities, toCity, distances, distance + currentDistance, currentMax
		    
		    cities.AddAt i, toCity
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetMinimum(cities() As String, fromCity As string, distances As Dictionary, currentDistance As Integer, ByRef currentMin As Integer)
		  if cities.Count = 0 then
		    currentMin = min( currentMin, currentDistance )
		    return
		  end if
		  
		  for i as integer = 0 to cities.LastIndex
		    var toCity as string = cities( i )
		    cities.RemoveAt i
		    
		    var distance as integer = GetDistance( distances, fromCity, toCity )
		    
		    GetMinimum cities, toCity, distances, distance + currentDistance, currentMin
		    
		    cities.AddAt i, toCity
		  next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Cities() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Distances As Dictionary
	#tag EndProperty


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"", Scope = Private
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
