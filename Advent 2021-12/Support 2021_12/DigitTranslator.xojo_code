#tag Class
Protected Class DigitTranslator
	#tag Method, Flags = &h0
		Sub AddDigit(digit As String)
		  //
		  // The digit can be 2 - 7 characters, so we will use them to determine what's possible
		  //
		  
		  static rxRemovePresent as RegEx
		  static rxRemoveAbsent as RegEx
		  
		  if rxRemovePresent is nil then
		    rxRemovePresent = new RegEx
		    rxRemovePresent.Options.ReplaceAllMatches = true
		    
		    rxRemoveAbsent = new RegEx
		    rxRemoveAbsent.Options.ReplaceAllMatches = true
		  end if
		  
		  rxRemovePresent.SearchPattern = "[" + digit + "]"
		  rxRemoveAbsent.SearchPattern = "[^" + digit + "]"
		  
		  var setCircuits() as string
		  
		  select case digit.Length
		  case 2 // 1
		    setCircuits = array( "TopRight", "BottomRight" )
		    
		  case 4 // 4
		    setCircuits = array( "TopLeft", "TopRight", "Middle", "BottomRight" )
		    
		  case 3 // 7
		    setCircuits = array( "Top", "TopRight", "BottomRight" )
		    
		  case 7 // 8
		    //
		    // This doesn't help us
		    //
		    return
		    
		  case 5 // 2, 3, 5
		    UnknownDigits.Add SortDigit( digit )
		    
		  case 6 // 6, 9, 0
		    UnknownDigits.Add SortDigit( digit )
		    
		  end select
		  
		  if setCircuits.Count <> 0 then
		    for each prop as Introspection.PropertyInfo in Props
		      var propName as string = prop.Name
		      
		      var currentValue as string = prop.Value( self )
		      var newValue as string
		      
		      if digit.Length = 4 then
		        newValue = newValue
		      end if
		      
		      if setCircuits.IndexOf( propName ) <> -1 then
		        newValue = rxRemoveAbsent.Replace( currentValue )
		      else
		        newValue = rxRemovePresent.Replace( currentValue )
		      end if
		      
		      prop.Value( self ) = newValue
		    next
		  end if
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  const kPossibles as string = "abcdefg"
		  
		  if Props.Count = 0 then
		    PropDict = new Dictionary
		    
		    var ti as Introspection.TypeInfo = Introspection.GetType( self )
		    for each prop as Introspection.PropertyInfo in ti.GetProperties
		      if prop.IsShared or prop.IsPrivate or prop.IsComputed then
		        continue for prop
		      end if
		      
		      select case true
		      case prop.Name.IndexOf( "Top" ) <> -1
		      case prop.Name.IndexOf( "Bottom" ) <> -1
		      case prop.Name.IndexOf( "Middle" ) <> -1
		      case else
		        continue for prop
		      end select
		      
		      Props.Add prop
		      
		      PropDict.Value( prop.Name ) = prop
		    next
		  end if
		  
		  for each prop as Introspection.PropertyInfo in Props
		    prop.Value( self ) = kPossibles
		  next
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decode(digit As String) As Integer
		  digit = SortDigit( digit )
		  return DecodedDigits.IndexOf( digit )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Finalize()
		  var possible1() as string
		  var possible2() as string
		  var possible3() as string
		  var possible4() as string
		  var possible5() as string
		  var possible6() as string
		  var possible7() as string
		  var possible8() as string
		  var possible9() as string
		  var possible0() as string
		  var positions() as string
		  
		  for each tr as string in TopRight.Characters
		    for each tl as string in TopLeft.Characters
		      for each m as string in Middle.Characters
		        for each bl as string in BottomLeft.Characters
		          for each br as string in BottomRight.Characters
		            for each b as string in Bottom.Characters
		              var arr() as string = ToStringArray( Top, tl, tr, m, bl, br, b )
		              if HasDupes( arr ) then
		                continue
		              end if
		              
		              possible1.Add ToDigit( tr, br )
		              possible2.Add ToDigit( Top, tr, m, bl, b )
		              possible3.Add ToDigit( Top, tr, m, br, b )
		              possible4.Add ToDigit( tl, tr, m, br )
		              possible5.Add ToDigit( Top, tl, m, br, b )
		              possible6.Add ToDigit( Top, tl, m, bl, br, b )
		              possible7.Add ToDigit( Top, tr, br )
		              possible8.Add ToDigit( Top, tl, tr, m, bl, br, b )
		              possible9.Add ToDigit( Top, tl, tr, m, br, b )
		              possible0.Add ToDigit( Top, tl, tr, bl, br, b )
		              
		              positions.Add String.FromArray( array( Top, tl, tr, m, bl, br, b ), "" )
		            next b
		          next br
		        next bl
		      next m
		    next tl
		  next tr
		  
		  var foundIndex as integer = -1
		  
		  for index as integer = 0 to positions.LastIndex
		    for each unknown as string in UnknownDigits
		      select case unknown.Length
		      case 5 // 2, 3, 5
		        if possible2( index ) <> unknown and possible3( index ) <> unknown and possible5( index ) <> unknown then
		          continue for index
		        end if
		        
		      case 6 // 6, 9, 0
		        if possible6( index ) <> unknown and possible9( index ) <> unknown and possible0( index ) <> unknown then
		          continue for index
		        end if
		      end select
		    next
		    //
		    // If we get here, we found it
		    //
		    if foundIndex <> -1 then
		      break
		    end if
		    foundIndex = index
		  next
		  
		  if foundIndex = -1 then
		    break
		  end if
		  
		  var position as string = positions( foundIndex )
		  TopLeft = position.Middle( 1, 1 )
		  TopRight = position.Middle( 2, 1 )
		  Middle = position.Middle( 3, 1 )
		  BottomLeft = position.Middle( 4, 1 )
		  BottomRight = position.Middle( 5, 1 )
		  Bottom = position.Middle( 6, 1 )
		  
		  DecodedDigits.ResizeTo( 9 )
		  
		  DecodedDigits( 0 ) = possible0( foundIndex )
		  DecodedDigits( 1 ) = possible1( foundIndex )
		  DecodedDigits( 2 ) = possible2( foundIndex )
		  DecodedDigits( 3 ) = possible3( foundIndex )
		  DecodedDigits( 4 ) = possible4( foundIndex )
		  DecodedDigits( 5 ) = possible5( foundIndex )
		  DecodedDigits( 6 ) = possible6( foundIndex )
		  DecodedDigits( 7 ) = possible7( foundIndex )
		  DecodedDigits( 8 ) = possible8( foundIndex )
		  DecodedDigits( 9 ) = possible9( foundIndex )
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasDupes(arr() As String) As Boolean
		  arr.Sort
		  
		  for i as integer = 1 to arr.LastIndex
		    if arr( i ) = arr( i - 1 ) then
		      return true
		    end if
		  next i
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SortDigit(digit As String) As String
		  var parts() as string = digit.Trim.Split( "" )
		  parts.Sort
		  return String.FromArray( parts, "" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToDigit(ParamArray digits() As String) As String
		  digits.Sort
		  return String.FromArray( digits, "" ).Trim
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToStringArray(ParamArray arr() As String) As String()
		  return arr
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Bottom As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BottomLeft As String
	#tag EndProperty

	#tag Property, Flags = &h0
		BottomRight As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DecodedDigits() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  for each prop as Introspection.PropertyInfo in Props
			    var value as string = prop.Value( self )
			    if value.Length <> 1 then
			      return false
			    end if
			  next
			  
			  return true
			  
			End Get
		#tag EndGetter
		IsDecoded As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Middle As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared PropDict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared Props() As Introspection.PropertyInfo
	#tag EndProperty

	#tag Property, Flags = &h0
		Top As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TopLeft As String
	#tag EndProperty

	#tag Property, Flags = &h0
		TopRight As String
	#tag EndProperty

	#tag Property, Flags = &h0
		UnknownDigits() As String
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
		#tag ViewProperty
			Name="TopLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopRight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Middle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomRight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bottom"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDecoded"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
