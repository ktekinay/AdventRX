#tag Class
Protected Class Advent_2020_12_21
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
		  return "Allergen Assessment"
		  
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
		Private Function CalculateResultA(input As String) As Integer
		  //
		  // Split the ingredients and allergens
		  //
		  
		  var db as Database = CreateDatabase
		  PopulateDatabase db, input
		  PrintDbInfo db, "Populated"
		  
		  DeleteImpossibleIngredients db
		  PrintDbInfo db, "Deleted"
		  
		  '//
		  '// Get the stats
		  '//
		  'var rs as RowSet = db.SelectSQL( _
		  '"SELECT COUNT(*)" + EndOfLine + _
		  '"FROM imported_row
		  ')
		  db = db
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateDatabase() As Database
		  var db as new SQLiteDatabase
		  db.WriteAheadLogging = true
		  
		  call db.Connect
		  
		  db.ExecuteSQL "CREATE TABLE allergen (name TEXT UNIQUE)"
		  
		  db.ExecuteSQL "CREATE TABLE ingredient (name TEXT UNIQUE)"
		  
		  db.ExecuteSQL "CREATE TABLE imported_row (row_num INTEGER, ingredient TEXT, allergen TEXT)"
		  db.ExecuteSQL "CREATE INDEX imported_row_row_num_idx ON imported_row (row_num)"
		  db.ExecuteSQL "CREATE INDEX imported_row_ingredient_idx ON imported_row (ingredient)"
		  db.ExecuteSQL "CREATE INDEX imported_row_allergen_idx ON imported_row (allergen)"
		  
		  db.ExecuteSQL "CREATE TABLE potential_match (allergen TEXT, ingredient TEXT)"
		  db.ExecuteSQL "CREATE UNIQUE INDEX potential_match_unique_idx ON potential_match (allergen, ingredient)"
		  
		  db.ExecuteSQL "CREATE TABLE confirmed_match (allergen TEXT, ingredient TEXT)"
		  db.ExecuteSQL "CREATE UNIQUE INDEX confirmed_match_unique_idx ON confirmed_match (allergen, ingredient)"
		  
		  db.ExecuteSQL "CREATE TABLE imported_row_stats (row_num INTEGER UNIQUE, ingredient_count INTEGER, allergen_count INTEGER)"
		  db.ExecuteSQL "CREATE INDEX imported_row_stats_allergen_count_idx ON imported_row_stats (allergen_count)"
		  db.ExecuteSQL "CREATE INDEX imported_row_stats_ingredient_count_idx ON imported_row_stats (ingredient_count)"
		  
		  
		  return db
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DeleteImpossibleIngredients(db As Database)
		  var rs as RowSet  = db.SelectSQL( _
		  "DELETE FROM imported_row AS this_row" + EndOfLine + _
		  "WHERE" + EndOfLine + _
		  "  NOT EXISTS (" + EndOfLine + _
		  "    SELECT * FROM imported_row AS prev_row" + EndOfLine + _
		  "    WHERE" + EndOfLine + _
		  "      prev_row.row_num < this_row.row_num" + EndOfLine + _
		  "      AND prev_row.allergen = this_row.allergen" + EndOfLine + _
		  "      AND prev_row.ingredient = this_row.ingredient" + EndOfLine + _
		  "  ) AND EXISTS (" + EndOfLine + _
		  "    SELECT * FROM imported_row AS prev_row" + EndOfLine + _
		  "    WHERE" + EndOfLine + _
		  "      prev_row.row_num < this_row.row_num" + EndOfLine + _
		  "      AND prev_row.allergen = this_row.allergen" + EndOfLine + _
		  "  ) RETURNING *" _
		  )
		  
		  print "IMPOSSIBLE ROWS:"
		  while not rs.AfterLastRow
		    print rs.Column( "row_num" ).StringValue + " " + rs.Column( "allergen" ).StringValue + " " + rs.Column( "ingredient" ).StringValue
		    rs.MoveToNextRow
		  wend
		  
		  print ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateDatabase(db As Database, input As String)
		  'db.ExecuteSQL "CREATE TABLE allergen (name TEXT)"
		  'db.ExecuteSQL "CREATE TABLE ingredient (name TEXT)"
		  'db.ExecuteSQL "CREATE TABLE imported_row (row_num INTEGER, ingredient TEXT, allergen TEXT)"
		  'db.ExecuteSQL "CREATE TABLE imported_row_stats (row_num INTEGER, ingredient_count INTEGER, allergen_count INTEGER)"
		  
		  
		  var insertIngredientPs as PreparedSQLStatement = db.Prepare( "INSERT INTO ingredient (name) VALUES (?) ON CONFLICT DO NOTHING" )
		  insertIngredientPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertAllergenPs as PreparedSQLStatement = db.Prepare( "INSERT INTO allergen (name) VALUES (?) ON CONFLICT DO NOTHING" )
		  insertAllergenPs.BindType( 0, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertRowPs as PreparedSQLStatement = db.Prepare( "INSERT INTO imported_row (row_num, ingredient, allergen) VALUES (?, ?, ?)" )
		  insertRowPs.BindType( 0, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowPs.BindType( 1, SQLitePreparedStatement.SQLITE_TEXT )
		  insertRowPs.BindType( 2, SQLitePreparedStatement.SQLITE_TEXT )
		  
		  var insertRowStatPs as PreparedSQLStatement = db.Prepare( "INSERT INTO imported_row_stats (row_num, ingredient_count, allergen_count) VALUES (?, ?, ?)" )
		  insertRowStatPs.BindType( 0, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowStatPs.BindType( 1, SQLitePreparedStatement.SQLITE_INTEGER )
		  insertRowStatPs.BindType( 2, SQLitePreparedStatement.SQLITE_INTEGER )
		  
		  var rows() as string = self.ToStringArray( input )
		  
		  var rowIndex as integer = 0
		  
		  for each row as string in rows
		    rowIndex = rowIndex + 1
		    
		    var parts() as string = row.Split( "(contains " )
		    parts( 1 ) = parts( 1 ).TrimRight( ")" )
		    var allergens() as string = parts( 1 ).Split( ", " )
		    
		    var ingredients() as string = parts( 0 ).Split( " " )
		    
		    insertRowStatPs.ExecuteSQL rowIndex, ingredients.Count, allergens.Count
		    
		    for each ingredient as string in ingredients
		      insertIngredientPs.ExecuteSQL ingredient
		    next
		    
		    for each allergen as string in allergens
		      insertAllergenPs.ExecuteSQL allergen
		    next
		    
		    for each ingredient as string in ingredients
		      for each allergen as string in allergens
		        insertRowPs.ExecuteSQL rowIndex, ingredient, allergen
		      next
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintDbInfo(db As Database, tag As String)
		  print tag
		  print "================================="
		  
		  var rs as RowSet
		  var tables() as string = array( "ingredient", "allergen", "imported_row", "imported_row_stats" )
		  
		  for each table as string in tables
		    rs = db.SelectSQL( "SELECT COUNT (*) FROM " + table )
		    print table + ": " + rs.ColumnAt( 0 ).StringValue
		  next
		  
		  rs = db.SelectSQL( "SELECT COUNT(*) FROM imported_row_stats WHERE allergen_count = 1" )
		  print "  rows where allergen_count = 1: " + rs.ColumnAt( 0 ).StringValue
		  
		  rs = db.SelectSQL( "SELECT COUNT(*) FROM imported_row_stats WHERE ingredient_count = 1" )
		  print "  rows where ingredient_count = 1: " + rs.ColumnAt( 0 ).StringValue
		  
		  
		  print ""
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = kPuzzleInput, Type = String, Dynamic = False, Default = \"", Scope = Private, Description = 5768656E2070617374696E67207468652064617461206973206E65636573736172792E
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"mxmxvkd kfcds sqjhc nhms (contains dairy\x2C fish)\ntrh fvjkl sbzzf mxmxvkd (contains dairy)\nsqjhc fvjkl (contains soy)\nsqjhc mxmxvkd sbzzf (contains fish)", Scope = Private
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
