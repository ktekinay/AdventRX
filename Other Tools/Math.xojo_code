#tag Module
Protected Module Math
	#tag Method, Flags = &h0
		Function GreatestCommonDivisor(val1 As Integer, val2 As Integer) As Integer
		  if val2 = 0 then
		    return val1
		  end if
		  
		  return GreatestCommonDivisor( val2, val1 mod val2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeastCommonDivisor(val1 As Integer, val2 As Integer) As Integer
		  if val1 = 0 or val2 = 0 then
		    raise new InvalidArgumentException
		  end if
		  
		  do
		    var minValue as integer = if( val1 < val2, val1, val2 )
		    var maxValue as integer = if( val1 > val2, val1, val2 )
		    
		    if minValue = maxValue then
		      return minValue
		    end if
		    
		    if minValue = 1 then
		      return maxValue
		    end if
		    if maxValue = 1 then
		      return minValue
		    end if
		    
		    if ( maxValue mod minValue ) = 0 then
		      maxValue = maxValue / minValue
		      val1 = minValue
		      val2 = maxValue
		      
		      continue
		    end if
		    
		    return minValue * maxValue
		  loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeastCommonMultiple(values() As Integer) As Integer
		  var val as integer = values( 0 )
		  
		  for i as integer = 1 to values.LastIndex
		    val = LeastCommonMultiple( val, values( i ) )
		  next
		  
		  return val
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LeastCommonMultiple(val1 As Integer, val2 As Integer) As Integer
		  if val1 > val2 then
		    return ( val1 / GreatestCommonDivisor( val1, val2 ) ) * val2
		  else
		    return ( val2 / GreatestCommonDivisor( val1, val2 ) ) * val1
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Log10(value As Double) As Double
		  static logOf10 as double = log( 10 )
		  
		  return log( value ) / logOf10
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SolveForXY(a As Integer, b As Integer, e As Integer, c As Integer, d As Integer, f As Integer) As Pair
		  //
		  // Uses Cramer's Rule to solve parallel equations for x and y.
		  //
		  // See https://www.1728.org/cramer.htm
		  //
		  // Given equations like
		  //
		  //   2x + 3y = 12
		  //   3x - 4y =  1
		  //
		  // Cramer's rule will use a matrix to solve for both unknowns.
		  // In this example, a = 2, b = 3, e = 12 from the top equation, and
		  // c = 3, d = -4, f = 1 from the bottom equation.
		  //
		  //   dn = (a • d) - (c • b)
		  //   dn = (2 • -4) - (3 • 3)
		  //   dn = -17
		  //
		  //   x = [(e • d) - (f • b)] ÷ dn
		  //   x = [(12 • -4) - (1 • 3)] ÷ -17
		  //   x = 3
		  //
		  //   y = [(a • f) -(c • e)] ÷ dn
		  //   y = [(2 • 1) -(3 • 12)] ÷ -17
		  //   y = 2
		  //
		  // Returns x and y as a Pair, or nil if the equations are unsolvable.
		  //
		  
		  var dn as integer = ( a * d ) - ( c * b )
		  
		  if dn = 0 then
		    return nil
		  end if
		  
		  var dx as integer = ( e * d ) - ( f * b )
		  
		  if dx mod dn <> 0 then
		    return nil
		  end if
		  
		  var dy as integer = ( a * f ) - ( c * e )
		  
		  if dy mod dn <> 0 then
		    return nil
		  end if
		  
		  var x as integer = dx \ dn
		  var y as integer = dy \ dn
		  
		  return x : y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SolveForXY(formula1 As String, formula2 As String) As Pair
		  //
		  // See other SolveForXY for description.
		  //
		  // This version will let you give the inputs as string, e.g.,
		  //   "2x + 3y = 12", "3x - 4y =  1"
		  //
		  
		  formula1 = formula1.ReplaceAllBytes( " ", "" )
		  formula2 = formula2.ReplaceAllBytes( " ", "" )
		  
		  var rx as new RegEx
		  var match as RegExMatch
		  
		  rx.SearchPattern = "(-?\d+)x"
		  
		  match = rx.Search( formula1 )
		  var a as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  match = rx.Search( formula2 )
		  var c as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  rx.SearchPattern = "(-?\d+)y"
		  
		  match = rx.Search( formula1 )
		  var b as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  match = rx.Search( formula2 )
		  var d as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  rx.SearchPattern = "=(-?\d+)"
		  
		  match = rx.Search( formula1 )
		  var e as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  match = rx.Search( formula2 )
		  var f as integer = match.SubExpressionString( 1 ).ToInteger
		  
		  return SolveForXY( a, b, e, c, d, f )
		  
		End Function
	#tag EndMethod


End Module
#tag EndModule
