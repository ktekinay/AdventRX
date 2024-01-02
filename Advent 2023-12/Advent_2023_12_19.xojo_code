#tag Class
Protected Class Advent_2023_12_19
Inherits AdventBase
	#tag Event
		Function ReturnDescription() As String
		  return "Unknown"
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnIsComplete() As Boolean
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ReturnName() As String
		  return ""
		  
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
		  var workflows as new Dictionary
		  var parts() as MachinePart
		  Parse input, workflows, parts
		  
		  var inWf as Workflow = workflows.Value( "in" )
		  var accWf as Workflow = workflows.Value( "A" )
		  var rejWf as Workflow = workflows.Value( "R" )
		  
		  for each part as MachinePart in parts
		    var currentWf as Workflow = inWf
		    
		    while currentWf <> accWf and currentWf <> rejWf
		      var nextWfName as string = currentWf.Process( part )
		      currentWf = workflows.Value( nextWfName )
		    wend
		    
		    currentWf.Parts.Add part
		  next
		  
		  var result as integer
		  
		  for each part as MachinePart in accWf.Parts
		    result = result + part.A + part.M + part.S + part.X
		  next
		  
		  return result : if( IsTest, 19114, 374873 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Variant
		  var workflows as new Dictionary
		  
		  ToWorkflows input.NthField( EndOfLine + EndOfLine, 1 ), workflows
		  var inWf as Workflow = workflows.Value( "in" )
		  
		  var result as integer = 1
		  
		  for each prop as string in array( "a", "m", "s", "x" )
		    var testRange as new Advent.Range( 1, 4000 )
		    var acc() as Advent.Range
		    
		    Follow testRange, prop, inWf, workflows, acc
		    
		    if IsTest then
		      print prop
		    end if
		    
		    Combine acc
		    
		    var count as integer
		    for each r as Advent.Range in acc
		      count = count + r.Length
		    next
		    
		    if count <> 0 then
		      result = result * count
		    end if
		    
		  next
		  
		  return result : if( IsTest, 167409079868000, 0 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Combine(ranges() As Advent.Range)
		  ranges.Sort AddressOf Advent.Range.Sorter
		  
		  if IsTest then
		    for each r as Advent.Range in ranges
		      print r.ToString + ", " + r.Length.ToString
		    next
		  end if
		  
		  for i as integer = ranges.LastIndex downto 1
		    var thisRange as Advent.Range = ranges( i )
		    var prevRange as Advent.Range = ranges( i - 1 )
		    
		    if thisRange.Overlaps( prevRange ) then
		      prevRange.Maximum = max( thisRange.Maximum, prevRange.Maximum )
		      ranges.RemoveAt i
		      
		    elseif thisRange.Minimum = ( prevRange.Maximum + 1 ) then
		      prevRange.Maximum = thisRange.Maximum
		      ranges.RemoveAt i
		      
		    end if
		  next
		  
		  if IsTest then
		    print "---"
		    
		    for each r as Advent.Range in ranges
		      print r.ToString + ", " + r.Length.ToString
		    next
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Follow(testRange As Advent.Range, prop As String, wf As Workflow, workflows As Dictionary, acc() As Advent.Range)
		  if testRange.Length <= 0 then
		    return
		  end if
		  
		  select case wf.Name
		  case "R"
		    return
		    
		  case "A"
		    acc.Add new Advent.Range( testRange )
		    return
		    
		  end select
		  
		  for each wfs as WorkflowStep in wf.Steps
		    if testRange.Length <= 0 then
		      return
		    end if
		    
		    testRange = new Advent.Range( testRange )
		    
		    if wfs.TestProperty = "" then
		      Follow testRange, prop, workflows.Value( wfs.ToWorkFlow ), workflows, acc
		      return
		    end if
		    
		    if wfs.TestProperty <> prop then
		      if wfs.ToWorkFlow <> "A" then
		        Follow testRange, prop, workflows.Value( wfs.ToWorkFlow ), workflows, acc
		      end if
		      
		      continue
		    end if
		    
		    var nextRange as new Advent.Range
		    
		    if wfs.Comparison = "<" then
		      nextRange.Minimum = testRange.Minimum
		      nextRange.Maximum = wfs.CompareValue - 1
		      testRange.Minimum = wfs.CompareValue
		    else // ">"
		      nextRange.Maximum = testRange.Maximum
		      nextRange.Minimum = wfs.CompareValue + 1
		      testRange.Maximum = wfs.CompareValue
		    end if
		    
		    Follow nextRange, prop, workflows.Value( wfs.ToWorkFlow ), workflows, acc
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parse(input As String, ByRef workflows As Dictionary, ByRef parts() As MachinePart)
		  workflows.RemoveAll
		  parts.RemoveAll
		  
		  var sections() as string = input.Split( EndOfLine + EndOfLine )
		  
		  var workflowSection as string = sections( 0 )
		  var partsSection as string = sections( 1 )
		  
		  ToWorkflows workflowSection, workflows
		  ToParts partsSection, parts
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToParts(data As String, parts() As MachinePart)
		  var rx as new RegEx
		  rx.SearchPattern = "(\w)=(\d+)"
		  
		  var rows() as string = data.Split( EndOfLine )
		  
		  for each row as string in rows
		    var part as new MachinePart
		    
		    var match as RegExMatch = rx.Search( row )
		    
		    while match isa RegExMatch
		      var prop as string = match.SubExpressionString( 1 )
		      var value as integer = match.SubExpressionString( 2 ).ToInteger
		      
		      select case prop
		      case "x"
		        part.X = value
		      case "m"
		        part.M = value
		      case "s"
		        part.S = value
		      case "a"
		        part.A = value
		      case else
		        break
		      end select
		      
		      match = rx.Search
		    wend
		    
		    parts.Add part
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToWorkflows(data As String, workflows As Dictionary)
		  var rx as new RegEx
		  rx.SearchPattern = "^(\w+)\{([^}]+)"
		  
		  var rows() as string = data.Split( EndOfLine )
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row )
		    var wf as new Workflow
		    wf.Name = match.SubExpressionString( 1 )
		    
		    var flows() as string = match.SubExpressionString( 2 ).Split( "," )
		    for each flow as string in flows
		      var wfStep as new WorkflowStep( flow )
		      wf.Steps.Add wfStep
		    next
		    
		    workflows.Value( wf.Name ) = wf
		  next
		  
		  var acc as new Workflow
		  acc.Name = "A"
		  workflows.Value( "A" ) = acc
		  
		  var rej as new Workflow
		  rej.Name = "R"
		  workflows.Value( "R" ) = rej
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"px{a<2006:qkq\x2Cm>2090:A\x2Crfg}\npv{a>1716:R\x2CA}\nlnx{m>1548:A\x2CA}\nrfg{s<537:gd\x2Cx>2440:R\x2CA}\nqs{s>3448:A\x2Clnx}\nqkq{x<1416:A\x2Ccrn}\ncrn{x>2662:A\x2CR}\nin{s<1351:px\x2Cqqz}\nqqz{s>2770:qs\x2Cm<1801:hdj\x2CR}\ngd{a>3333:R\x2CR}\nhdj{m>838:A\x2Cpv}\n\n{x\x3D787\x2Cm\x3D2655\x2Ca\x3D1222\x2Cs\x3D2876}\n{x\x3D1679\x2Cm\x3D44\x2Ca\x3D2067\x2Cs\x3D496}\n{x\x3D2036\x2Cm\x3D264\x2Ca\x3D79\x2Cs\x3D2244}\n{x\x3D2461\x2Cm\x3D1339\x2Ca\x3D466\x2Cs\x3D291}\n{x\x3D2127\x2Cm\x3D1623\x2Ca\x3D2188\x2Cs\x3D1013}", Scope = Private
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
