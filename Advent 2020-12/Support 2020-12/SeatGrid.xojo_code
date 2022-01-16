#tag Class
Protected Class SeatGrid
Inherits ObjectGrid
	#tag Method, Flags = &h0
		Function Operator_Subscript(row As Integer, col As Integer) As Seat
		  return Seat( super.Operator_Subscript( row, col ) )
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
