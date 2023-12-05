#tag Class
Protected Class Advent_2023_12_05
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Follow maps to get to the lowest location value"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return "If You Give A Seed A Fertilizer"
		  
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
		  var seeds() as Seed
		  var maps() as SeedMap
		  
		  Parse( input, seeds, maps )
		  
		  var minLocation as integer = 0
		  
		  for each seed as Seed in seeds
		    var id as integer = seed.Value
		    
		    if id = 13 then
		      id = id
		    end if
		    
		    for each map as SeedMap in maps
		      id = map.Corresponding( id )
		      seed.Trail.Add id
		    next
		    
		    var loc as integer = seed.Trail( seed.Trail.LastIndex )
		    if minLocation = 0 or minLocation > loc then
		      minLocation = loc
		    end if
		  next
		  
		  return minLocation : if( IsTest, 35, 265018614 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var seeds() as Seed
		  var maps() as SeedMap
		  
		  Parse( input, seeds, maps )
		  
		  var seedRanges() as Advent.Range
		  
		  for i as integer = 0 to seeds.LastIndex step 2
		    var s1 as Seed = seeds( i )
		    var s2 as Seed = seeds( i + 1 )
		    
		    var sr as new Advent.Range( s1.Value, s1.Value + s2.Value - 1 )
		    seedRanges.Add sr
		  next
		  
		  var minLocation as integer = 0
		  
		  for each sr as Advent.Range in seedRanges
		    var currentRange as new Advent.Range( sr )
		    var testRanges() as Advent.Range = Array( currentRange )
		    
		    for each map as SeedMap in maps
		      
		      var loopIt as boolean = true
		      var newTestRanges() as Advent.Range
		      
		      while loopIt
		        loopIt = false
		        
		        var retest() as Advent.Range
		        
		        for each testRange as Advent.Range in testRanges
		          var result() as Advent.Range = map.Corresponding( testRange )
		          newTestRanges.Add result.Pop
		          
		          for each r as Advent.Range in result
		            retest.Add r
		          next
		          
		        next
		        
		        if retest.Count <> 0 then
		          testRanges = retest
		          loopIt = true
		        else
		          testRanges = newTestRanges
		        end if
		      wend
		      
		    next map
		    
		    for each r as Advent.Range in testRanges
		      if minLocation = 0 or minLocation > r.Minimum then
		        minLocation = r.Minimum
		      end if
		    next
		  next
		  
		  return minLocation : if( IsTest, 46, 63179500 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parse(input As String, ByRef toSeeds() As Seed, ByRef toMaps() As SeedMap)
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var seedStrings() as string = sections( 0 ).NthField( ": ", 2 ).Split( " " )
		  var seeds() as Seed
		  for each seedString as string in seedStrings
		    var seed as new Seed
		    seed.Value = seedString.ToInteger
		    seeds.Add seed
		  next
		  
		  toSeeds = seeds
		  
		  sections.RemoveAt 0
		  toMaps.RemoveAll
		  
		  var rxName as new RegEx
		  rxName.SearchPattern = "^[^-]+-to-(\w+)"
		  
		  var rxRange as new RegEx
		  rxRange.SearchPattern = "^(\d+) (\d+) (\d+)"
		  
		  for each section as string in sections
		    var name as string = rxName.Search( section ).SubExpressionString( 1 )
		    
		    var sm as new SeedMap
		    sm.Name = name
		    
		    var match as RegExMatch = rxRange.Search( section )
		    while match isa object
		      var destStartValue as integer = match.SubExpressionString( 1 ).ToInteger
		      var sourceStartValue as integer = match.SubExpressionString( 2 ).ToInteger
		      var distance as integer = match.SubExpressionString( 3 ).ToInteger - 1
		      
		      var sourceRange as new Advent.Range( sourceStartValue, sourceStartValue + distance )
		      var destRange as new Advent.Range( destStartValue, destStartValue + distance )
		      
		      sm.Add sourceRange, destRange
		      
		      match = rxRange.Search
		    wend
		    
		    toMaps.Add sm
		  next
		  
		  return
		  return
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"seeds: 79 14 55 13\n\nseed-to-soil map:\n50 98 2\n52 50 48\n\nsoil-to-fertilizer map:\n0 15 37\n37 52 2\n39 0 15\n\nfertilizer-to-water map:\n49 53 8\n0 11 42\n42 0 7\n57 7 4\n\nwater-to-light map:\n88 18 7\n18 25 70\n\nlight-to-temperature map:\n45 77 23\n81 45 19\n68 64 13\n\ntemperature-to-humidity map:\n0 69 1\n1 0 69\n\nhumidity-to-location map:\n60 56 37\n56 93 4", Scope = Private
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
