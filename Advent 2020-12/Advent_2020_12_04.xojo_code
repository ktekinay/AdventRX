#tag Class
Protected Class Advent_2020_12_04
Inherits AdventBase
	#tag Event
		Function ReturnIsComplete() As Boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function RunA() As Variant
		  return CalculateResultA( GetPuzzleInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Variant
		  return CalculateResultB( GetPuzzleInput )
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Variant
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestB() As Variant
		  return CalculateResultB( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var recs() as variant = ParseInput( input )
		  var required() as string = array( "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" )
		  
		  var validCount as integer
		  for each rec as Dictionary in recs
		    for each field as string in required
		      if not rec.HasKey( field ) then
		        //
		        // It's not valid
		        //
		        continue for rec
		      end if
		    next
		    
		    //
		    // If we get here, it's valid
		    //
		    validCount = validCount + 1
		  next
		  
		  return validCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var recs() as variant = ParseInput( input )
		  var required() as string = array( "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" )
		  
		  var rxHgt as new RegEx
		  rxHgt.SearchPattern = "^(\d+)(cm|in)$"
		  
		  var rxHcl as new RegEx
		  rxHcl.SearchPattern = "^#[[:xdigit:]]{6}$"
		  
		  var validEcl() as string = array( "amb", "blu", "brn", "gry", "grn", "hzl", "oth" )
		  
		  var rxPid as new RegEx
		  rxPid.SearchPattern = "^\d{9}$"
		  
		  var validRecs() as Dictionary
		  
		  for each rec as Dictionary in recs
		    for each field as string in required
		      if not rec.HasKey( field ) then
		        //
		        // It's not valid
		        //
		        continue for rec
		      end if
		      
		      var value as string = rec.Value( field )
		      var isValid as boolean = true // Assume this
		      
		      select case true
		      case field = "byr" and value.ToInteger.IsBetween( 1920, 2002 ) and value.Length = 4
		      case field = "iyr" and value.ToInteger.IsBetween( 2010, 2020 ) and value.Length = 4
		      case field = "eyr" and value.ToInteger.IsBetween( 2020, 2030 ) and value.Length = 4
		      case field = "hgt"
		        var match as RegExMatch = rxHgt.Search( value )
		        if match is nil then
		          isValid = false
		        else
		          var num as integer = match.SubExpressionString( 1 ).ToInteger
		          var unit as string = match.SubExpressionString( 2 )
		          
		          select case unit
		          case "cm"
		            isValid = num.IsBetween( 150, 193 ) 
		          case "in"
		            isValid = num.IsBetween( 59, 76 )
		          case else
		            isValid = false
		          end select
		          
		        end if
		      case field = "hcl" and rxHcl.Search( value ) isa object
		      case field = "ecl" and validEcl.IndexOf( value ) <> -1
		      case field = "pid" and rxPid.Search( value ) isa object
		      case field = "cid"
		      case else
		        //
		        // Not valid
		        //
		        isValid = false
		        
		      end select
		      
		      if not isValid then
		        continue for rec
		      end if
		    next
		    
		    //
		    // If we get here, it's valid
		    //
		    validRecs.Add rec
		  next
		  
		  validRecs = validRecs
		  
		  return validRecs.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseInput(input As String) As Variant()
		  input = input.Trim.ReplaceLineEndings( EndOfLine )
		  
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  for i as integer = 0 to sections.LastRowIndex
		    var section as string = sections( i )
		    
		    section = section.ReplaceAll( " ", """, """ )
		    section = section.ReplaceAll( EndOfLine, """, """ )
		    section = section.ReplaceAll( ":", """:""" )
		    
		    section = "{""" + section + """}"
		    sections( i ) = section
		  next
		  
		  var jsonString as string = "[" + String.FromArray( sections, "," ) + "]"
		  var json() as variant = ParseJSON( jsonString )
		  return json
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\niyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\nhcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\nhcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in", Scope = Private
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
