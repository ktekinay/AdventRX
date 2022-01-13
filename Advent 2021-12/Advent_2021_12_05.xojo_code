#tag Class
Protected Class Advent_2021_12_05
Inherits AdventBase
	#tag Event
		Function RunA() As Integer
		  return CalculateResultA( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunB() As Integer
		  return CalculateResultB( kInput )
		  
		End Function
	#tag EndEvent

	#tag Event
		Function RunTestA() As Integer
		  return CalculateResultA( kTestInput )
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CalculateResultA(input As String) As Integer
		  var grid( kMaxIndex, kMaxIndex ) as integer
		  
		  var coords() as pair = ToPoints( input )
		  
		  for each coord as pair in coords
		    var startPoint as Xojo.Point = coord.Left
		    var endPoint as Xojo.Point = coord.Right
		    
		    if startPoint.X = endPoint.X or startPoint.Y = endPoint.Y then
		      var startX as integer = startPoint.X
		      var endX as integer = endPoint.X
		      MaybeSwap startX, endX
		      
		      var startY as integer = startPoint.Y
		      var endY as integer = endPoint.Y
		      MaybeSwap startY, endY
		      
		      for x as integer = startX to endX
		        for y as integer = startY to endY
		          grid( x, y ) = grid( x, y ) + 1
		        next
		      next
		    end if
		  next coord
		  
		  return CountGrid( grid )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CalculateResultB(input As String) As Integer
		  var grid( kMaxIndex, kMaxIndex ) as integer
		  
		  var coords() as pair = ToPoints( input )
		  
		  for each coord as pair in coords
		    var startPoint as Xojo.Point = coord.Left
		    var endPoint as Xojo.Point = coord.Right
		    
		    var x as integer = startPoint.X
		    var y as integer = startPoint.Y
		    
		    var xInc as integer = GetIncrement( startPoint.X, endPoint.X )
		    var yInc as integer = GetIncrement( startPoint.Y, endPoint.Y )
		    
		    do
		      grid( x, y ) = grid( x, y ) + 1
		      
		      if x = endPoint.X and y = endPoint.Y then
		        exit
		      end if
		      x = x + xInc
		      y = y + yInc
		    loop
		    
		  next coord
		  
		  return CountGrid( grid )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CountGrid(grid(, ) As Integer) As Integer
		  var count as integer
		  for x as integer = 0 to kMaxIndex
		    for y as integer = 0 to kMaxIndex
		      if grid( x, y ) >= 2 then
		        count = count + 1
		      end if
		    next y
		  next x
		  
		  return count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetIncrement(startVal As Integer, endVal As Integer) As Integer
		  if startVal < endVal then
		    return 1
		  elseif startVal > endVal then
		    return -1
		  else
		    return 0
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybeSwap(ByRef v1 As Integer, ByRef v2 As Integer)
		  if v1 > v2 then
		    var temp as integer = v1
		    v1 = v2
		    v2 = temp
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToPoints(input As String) As Pair()
		  var rows() as string = input.Trim.ReplaceLineEndings( EndOfLine ).Split( EndOfLine )
		  
		  var result() as pair
		  
		  var rx as new RegEx
		  rx.SearchPattern = "(\d+),(\d+) *-> *(\d+),(\d+)$"
		  
		  for each row as string in rows
		    var match as RegExMatch = rx.Search( row.Trim )
		    var p1 as new Xojo.Point
		    p1.X = match.SubExpressionString( 1 ).ToInteger
		    p1.Y = match.SubExpressionString( 2 ).ToInteger
		    
		    var p2 as new Xojo.Point
		    p2.X = match.SubExpressionString( 3 ).ToInteger
		    p2.Y = match.SubExpressionString( 4 ).ToInteger
		    
		    result.Add p1 : p2
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kInput, Type = String, Dynamic = False, Default = \"645\x2C570 -> 517\x2C570\n100\x2C409 -> 200\x2C409\n945\x2C914 -> 98\x2C67\n22\x2C934 -> 22\x2C681\n935\x2C781 -> 524\x2C370\n750\x2C304 -> 854\x2C408\n974\x2C27 -> 26\x2C975\n529\x2C58 -> 979\x2C58\n979\x2C515 -> 550\x2C944\n925\x2C119 -> 17\x2C119\n178\x2C594 -> 45\x2C461\n252\x2C366 -> 92\x2C206\n25\x2C593 -> 250\x2C593\n956\x2C34 -> 21\x2C969\n200\x2C671 -> 200\x2C369\n628\x2C614 -> 628\x2C637\n697\x2C428 -> 237\x2C428\n554\x2C40 -> 554\x2C949\n927\x2C197 -> 469\x2C197\n504\x2C779 -> 593\x2C868\n227\x2C882 -> 227\x2C982\n56\x2C905 -> 56\x2C81\n438\x2C874 -> 566\x2C746\n989\x2C73 -> 113\x2C949\n82\x2C36 -> 616\x2C570\n670\x2C423 -> 670\x2C873\n100\x2C435 -> 291\x2C435\n242\x2C81 -> 978\x2C817\n367\x2C335 -> 367\x2C332\n890\x2C584 -> 116\x2C584\n572\x2C192 -> 572\x2C561\n391\x2C516 -> 391\x2C559\n525\x2C62 -> 525\x2C540\n787\x2C540 -> 812\x2C515\n749\x2C732 -> 423\x2C406\n745\x2C911 -> 694\x2C911\n805\x2C18 -> 972\x2C18\n701\x2C565 -> 280\x2C144\n930\x2C92 -> 129\x2C893\n15\x2C989 -> 970\x2C34\n409\x2C920 -> 409\x2C345\n192\x2C743 -> 312\x2C863\n724\x2C12 -> 29\x2C707\n323\x2C664 -> 323\x2C897\n161\x2C423 -> 391\x2C653\n59\x2C363 -> 250\x2C554\n407\x2C676 -> 19\x2C288\n449\x2C585 -> 449\x2C301\n914\x2C798 -> 914\x2C806\n917\x2C401 -> 288\x2C401\n588\x2C800 -> 647\x2C800\n897\x2C883 -> 897\x2C276\n115\x2C606 -> 41\x2C532\n692\x2C482 -> 777\x2C482\n428\x2C736 -> 69\x2C736\n405\x2C44 -> 405\x2C632\n198\x2C482 -> 198\x2C620\n988\x2C816 -> 988\x2C598\n254\x2C461 -> 186\x2C393\n560\x2C783 -> 208\x2C783\n856\x2C766 -> 215\x2C125\n182\x2C30 -> 569\x2C30\n504\x2C242 -> 656\x2C242\n393\x2C929 -> 131\x2C929\n597\x2C359 -> 26\x2C930\n502\x2C690 -> 255\x2C443\n149\x2C608 -> 149\x2C748\n293\x2C662 -> 622\x2C662\n697\x2C154 -> 697\x2C228\n587\x2C804 -> 983\x2C804\n715\x2C63 -> 715\x2C709\n496\x2C831 -> 23\x2C358\n461\x2C48 -> 68\x2C441\n927\x2C565 -> 595\x2C565\n972\x2C350 -> 689\x2C350\n728\x2C438 -> 728\x2C221\n173\x2C134 -> 173\x2C804\n720\x2C368 -> 121\x2C368\n690\x2C66 -> 201\x2C66\n218\x2C680 -> 841\x2C680\n80\x2C792 -> 80\x2C467\n624\x2C319 -> 624\x2C461\n248\x2C348 -> 532\x2C64\n357\x2C260 -> 505\x2C408\n296\x2C814 -> 13\x2C531\n819\x2C216 -> 819\x2C932\n696\x2C233 -> 696\x2C840\n219\x2C93 -> 868\x2C93\n537\x2C63 -> 905\x2C63\n777\x2C940 -> 777\x2C84\n286\x2C133 -> 286\x2C735\n969\x2C967 -> 969\x2C823\n254\x2C222 -> 859\x2C827\n426\x2C728 -> 426\x2C388\n854\x2C561 -> 854\x2C363\n755\x2C861 -> 755\x2C947\n570\x2C754 -> 439\x2C754\n333\x2C351 -> 333\x2C828\n436\x2C693 -> 436\x2C262\n982\x2C987 -> 172\x2C177\n267\x2C178 -> 267\x2C270\n218\x2C201 -> 747\x2C730\n811\x2C602 -> 829\x2C584\n602\x2C659 -> 766\x2C659\n536\x2C544 -> 483\x2C597\n280\x2C881 -> 547\x2C881\n584\x2C125 -> 129\x2C125\n386\x2C210 -> 757\x2C210\n605\x2C855 -> 605\x2C668\n19\x2C985 -> 988\x2C16\n980\x2C655 -> 836\x2C655\n73\x2C189 -> 267\x2C383\n621\x2C645 -> 533\x2C645\n36\x2C12 -> 255\x2C231\n538\x2C889 -> 130\x2C481\n921\x2C217 -> 921\x2C724\n873\x2C59 -> 873\x2C311\n76\x2C918 -> 970\x2C24\n694\x2C448 -> 694\x2C983\n573\x2C891 -> 573\x2C337\n796\x2C358 -> 403\x2C358\n532\x2C928 -> 351\x2C928\n123\x2C717 -> 123\x2C446\n874\x2C714 -> 874\x2C886\n350\x2C458 -> 728\x2C458\n798\x2C140 -> 798\x2C242\n832\x2C406 -> 864\x2C406\n188\x2C55 -> 188\x2C641\n903\x2C376 -> 509\x2C376\n50\x2C954 -> 989\x2C15\n42\x2C294 -> 25\x2C294\n544\x2C273 -> 974\x2C273\n804\x2C756 -> 103\x2C55\n398\x2C184 -> 570\x2C12\n82\x2C179 -> 902\x2C179\n461\x2C728 -> 905\x2C284\n429\x2C241 -> 26\x2C241\n128\x2C715 -> 207\x2C715\n239\x2C545 -> 934\x2C545\n978\x2C769 -> 978\x2C576\n250\x2C77 -> 515\x2C77\n521\x2C533 -> 521\x2C434\n955\x2C844 -> 314\x2C203\n144\x2C601 -> 702\x2C43\n313\x2C784 -> 339\x2C784\n388\x2C692 -> 805\x2C275\n540\x2C872 -> 540\x2C72\n971\x2C19 -> 17\x2C973\n816\x2C540 -> 386\x2C540\n933\x2C246 -> 560\x2C619\n800\x2C600 -> 387\x2C187\n272\x2C791 -> 129\x2C934\n908\x2C133 -> 110\x2C931\n759\x2C191 -> 910\x2C40\n420\x2C479 -> 749\x2C150\n604\x2C946 -> 804\x2C946\n633\x2C404 -> 771\x2C266\n948\x2C974 -> 948\x2C734\n735\x2C198 -> 105\x2C828\n889\x2C653 -> 889\x2C688\n157\x2C172 -> 822\x2C837\n206\x2C670 -> 297\x2C670\n50\x2C122 -> 792\x2C864\n656\x2C664 -> 27\x2C664\n966\x2C33 -> 523\x2C33\n985\x2C40 -> 101\x2C924\n394\x2C367 -> 574\x2C547\n440\x2C573 -> 268\x2C573\n159\x2C989 -> 159\x2C130\n867\x2C123 -> 867\x2C891\n316\x2C153 -> 316\x2C249\n680\x2C59 -> 773\x2C152\n52\x2C928 -> 52\x2C182\n128\x2C595 -> 225\x2C595\n508\x2C719 -> 591\x2C719\n595\x2C447 -> 709\x2C333\n930\x2C783 -> 283\x2C136\n366\x2C236 -> 283\x2C236\n820\x2C512 -> 381\x2C951\n135\x2C450 -> 135\x2C766\n750\x2C838 -> 534\x2C838\n259\x2C304 -> 626\x2C671\n414\x2C631 -> 916\x2C129\n193\x2C862 -> 901\x2C154\n362\x2C595 -> 362\x2C209\n377\x2C215 -> 377\x2C499\n723\x2C16 -> 577\x2C16\n335\x2C238 -> 790\x2C693\n670\x2C266 -> 871\x2C65\n288\x2C313 -> 213\x2C313\n48\x2C423 -> 592\x2C967\n960\x2C323 -> 911\x2C323\n177\x2C182 -> 177\x2C235\n773\x2C918 -> 757\x2C918\n216\x2C432 -> 147\x2C432\n808\x2C500 -> 656\x2C500\n205\x2C451 -> 776\x2C451\n598\x2C985 -> 598\x2C608\n193\x2C253 -> 241\x2C205\n912\x2C384 -> 912\x2C532\n214\x2C194 -> 214\x2C738\n508\x2C356 -> 508\x2C792\n16\x2C372 -> 30\x2C372\n384\x2C854 -> 986\x2C252\n361\x2C569 -> 851\x2C569\n923\x2C550 -> 923\x2C441\n271\x2C257 -> 318\x2C304\n651\x2C345 -> 651\x2C397\n885\x2C14 -> 929\x2C14\n199\x2C547 -> 925\x2C547\n803\x2C176 -> 104\x2C875\n840\x2C302 -> 197\x2C945\n971\x2C743 -> 355\x2C127\n684\x2C951 -> 684\x2C292\n58\x2C867 -> 58\x2C953\n351\x2C187 -> 351\x2C831\n701\x2C413 -> 701\x2C728\n482\x2C159 -> 134\x2C159\n118\x2C52 -> 950\x2C884\n115\x2C968 -> 115\x2C137\n437\x2C739 -> 627\x2C929\n653\x2C153 -> 549\x2C153\n604\x2C504 -> 560\x2C460\n538\x2C865 -> 840\x2C563\n114\x2C876 -> 114\x2C124\n152\x2C899 -> 925\x2C126\n973\x2C224 -> 973\x2C387\n492\x2C360 -> 861\x2C729\n927\x2C902 -> 108\x2C83\n754\x2C678 -> 754\x2C647\n526\x2C671 -> 423\x2C671\n675\x2C608 -> 243\x2C608\n147\x2C241 -> 147\x2C242\n456\x2C770 -> 456\x2C665\n953\x2C50 -> 102\x2C901\n415\x2C869 -> 415\x2C733\n979\x2C533 -> 169\x2C533\n336\x2C385 -> 336\x2C18\n927\x2C176 -> 927\x2C587\n370\x2C317 -> 933\x2C880\n450\x2C349 -> 450\x2C103\n755\x2C235 -> 408\x2C235\n342\x2C55 -> 931\x2C55\n417\x2C707 -> 887\x2C237\n141\x2C95 -> 131\x2C85\n776\x2C209 -> 590\x2C23\n39\x2C732 -> 469\x2C302\n743\x2C602 -> 743\x2C358\n473\x2C439 -> 473\x2C545\n270\x2C290 -> 270\x2C640\n904\x2C963 -> 949\x2C963\n71\x2C91 -> 956\x2C976\n865\x2C757 -> 276\x2C757\n59\x2C72 -> 966\x2C979\n46\x2C184 -> 788\x2C926\n360\x2C833 -> 561\x2C833\n120\x2C452 -> 528\x2C452\n704\x2C927 -> 158\x2C381\n140\x2C481 -> 140\x2C350\n929\x2C920 -> 929\x2C342\n328\x2C381 -> 328\x2C866\n897\x2C389 -> 227\x2C389\n341\x2C614 -> 29\x2C614\n609\x2C327 -> 609\x2C582\n727\x2C858 -> 727\x2C941\n349\x2C536 -> 349\x2C500\n280\x2C959 -> 259\x2C959\n973\x2C637 -> 832\x2C637\n161\x2C255 -> 979\x2C255\n512\x2C826 -> 149\x2C826\n308\x2C769 -> 22\x2C769\n60\x2C692 -> 60\x2C262\n787\x2C31 -> 753\x2C31\n932\x2C166 -> 932\x2C127\n514\x2C77 -> 514\x2C646\n535\x2C434 -> 535\x2C979\n838\x2C799 -> 838\x2C332\n565\x2C956 -> 565\x2C477\n74\x2C195 -> 274\x2C195\n916\x2C715 -> 907\x2C715\n721\x2C655 -> 721\x2C542\n180\x2C784 -> 928\x2C784\n16\x2C128 -> 313\x2C128\n23\x2C330 -> 23\x2C704\n530\x2C723 -> 530\x2C88\n869\x2C272 -> 765\x2C376\n878\x2C185 -> 353\x2C185\n72\x2C800 -> 514\x2C800\n319\x2C117 -> 307\x2C117\n436\x2C405 -> 496\x2C345\n327\x2C459 -> 641\x2C145\n358\x2C309 -> 661\x2C612\n60\x2C225 -> 811\x2C976\n113\x2C130 -> 794\x2C130\n559\x2C950 -> 32\x2C423\n626\x2C110 -> 626\x2C319\n50\x2C39 -> 989\x2C978\n257\x2C627 -> 799\x2C627\n581\x2C843 -> 581\x2C493\n869\x2C18 -> 208\x2C18\n184\x2C395 -> 184\x2C263\n454\x2C888 -> 165\x2C599\n637\x2C920 -> 637\x2C544\n170\x2C982 -> 273\x2C982\n98\x2C354 -> 668\x2C924\n32\x2C409 -> 32\x2C925\n154\x2C175 -> 273\x2C294\n425\x2C896 -> 870\x2C451\n198\x2C319 -> 615\x2C736\n170\x2C582 -> 170\x2C712\n141\x2C645 -> 141\x2C639\n482\x2C768 -> 486\x2C768\n940\x2C969 -> 24\x2C53\n680\x2C360 -> 959\x2C360\n315\x2C905 -> 315\x2C96\n22\x2C666 -> 22\x2C247\n722\x2C40 -> 722\x2C714\n585\x2C31 -> 585\x2C21\n479\x2C254 -> 307\x2C254\n291\x2C182 -> 291\x2C855\n684\x2C698 -> 402\x2C698\n20\x2C984 -> 988\x2C16\n256\x2C424 -> 17\x2C663\n825\x2C380 -> 820\x2C385\n254\x2C622 -> 254\x2C315\n98\x2C855 -> 98\x2C694\n220\x2C719 -> 220\x2C117\n615\x2C653 -> 656\x2C694\n427\x2C12 -> 427\x2C745\n20\x2C64 -> 828\x2C872\n739\x2C203 -> 434\x2C203\n546\x2C576 -> 130\x2C160\n730\x2C835 -> 299\x2C835\n927\x2C512 -> 927\x2C586\n411\x2C192 -> 868\x2C192\n917\x2C630 -> 678\x2C630\n620\x2C588 -> 620\x2C26\n786\x2C488 -> 486\x2C488\n746\x2C640 -> 251\x2C145\n585\x2C556 -> 585\x2C119\n977\x2C202 -> 762\x2C202\n587\x2C244 -> 587\x2C877\n693\x2C479 -> 693\x2C859\n59\x2C816 -> 59\x2C475\n191\x2C941 -> 878\x2C254\n150\x2C920 -> 926\x2C144\n856\x2C397 -> 856\x2C739\n380\x2C965 -> 549\x2C796\n637\x2C323 -> 909\x2C595\n848\x2C219 -> 304\x2C763\n123\x2C146 -> 589\x2C146\n546\x2C122 -> 651\x2C122\n131\x2C711 -> 814\x2C28\n727\x2C274 -> 296\x2C274\n101\x2C546 -> 479\x2C168\n508\x2C517 -> 615\x2C410\n492\x2C115 -> 492\x2C250\n212\x2C65 -> 770\x2C623\n118\x2C938 -> 857\x2C199\n623\x2C843 -> 98\x2C843\n86\x2C153 -> 701\x2C768\n81\x2C98 -> 81\x2C604\n173\x2C313 -> 173\x2C533\n792\x2C396 -> 792\x2C242\n975\x2C985 -> 10\x2C20\n762\x2C661 -> 726\x2C661\n216\x2C327 -> 216\x2C122\n446\x2C658 -> 98\x2C658\n85\x2C184 -> 314\x2C184\n165\x2C750 -> 313\x2C750\n729\x2C583 -> 729\x2C640\n382\x2C36 -> 382\x2C326\n487\x2C32 -> 225\x2C32\n389\x2C722 -> 582\x2C915\n954\x2C965 -> 86\x2C965\n747\x2C376 -> 747\x2C96\n254\x2C259 -> 254\x2C482\n149\x2C256 -> 149\x2C871\n893\x2C207 -> 708\x2C22\n195\x2C907 -> 195\x2C82\n342\x2C686 -> 457\x2C571\n647\x2C469 -> 468\x2C469\n150\x2C525 -> 832\x2C525\n90\x2C907 -> 90\x2C31\n389\x2C554 -> 389\x2C318\n138\x2C327 -> 138\x2C310\n861\x2C126 -> 861\x2C549\n355\x2C583 -> 355\x2C534\n591\x2C182 -> 181\x2C592\n73\x2C84 -> 897\x2C908\n326\x2C989 -> 425\x2C989\n835\x2C688 -> 724\x2C799\n844\x2C493 -> 844\x2C974\n172\x2C436 -> 172\x2C12\n536\x2C933 -> 48\x2C445\n192\x2C531 -> 287\x2C531\n286\x2C547 -> 80\x2C547\n929\x2C795 -> 697\x2C795\n790\x2C681 -> 433\x2C681\n692\x2C229 -> 731\x2C229\n377\x2C667 -> 14\x2C304\n535\x2C226 -> 116\x2C645\n338\x2C861 -> 338\x2C343\n668\x2C160 -> 853\x2C160\n188\x2C157 -> 667\x2C636\n62\x2C934 -> 951\x2C45\n948\x2C820 -> 978\x2C820\n860\x2C884 -> 157\x2C884\n794\x2C251 -> 783\x2C251\n317\x2C381 -> 591\x2C655\n459\x2C876 -> 459\x2C307\n146\x2C822 -> 903\x2C65\n374\x2C739 -> 891\x2C739\n619\x2C575 -> 973\x2C929\n544\x2C351 -> 544\x2C124\n300\x2C335 -> 818\x2C335\n158\x2C220 -> 418\x2C480\n107\x2C953 -> 988\x2C953\n304\x2C753 -> 543\x2C753\n948\x2C95 -> 140\x2C903\n832\x2C451 -> 526\x2C145\n966\x2C34 -> 402\x2C598\n72\x2C123 -> 716\x2C123\n336\x2C294 -> 84\x2C294\n116\x2C605 -> 116\x2C889\n700\x2C742 -> 700\x2C217\n551\x2C554 -> 973\x2C554\n684\x2C181 -> 66\x2C799\n86\x2C949 -> 86\x2C173\n834\x2C361 -> 834\x2C942\n508\x2C668 -> 627\x2C549\n213\x2C695 -> 704\x2C695\n260\x2C979 -> 868\x2C371\n825\x2C435 -> 825\x2C67\n956\x2C854 -> 66\x2C854\n390\x2C444 -> 697\x2C444\n360\x2C450 -> 720\x2C810\n153\x2C514 -> 794\x2C514\n253\x2C261 -> 253\x2C298\n925\x2C679 -> 925\x2C499\n391\x2C282 -> 441\x2C282\n86\x2C366 -> 779\x2C366\n687\x2C312 -> 687\x2C629\n304\x2C172 -> 732\x2C600\n571\x2C518 -> 263\x2C518\n814\x2C252 -> 118\x2C252\n108\x2C920 -> 108\x2C162\n154\x2C965 -> 928\x2C191\n635\x2C875 -> 635\x2C947\n986\x2C31 -> 47\x2C970\n746\x2C35 -> 746\x2C636\n735\x2C849 -> 334\x2C448\n826\x2C510 -> 906\x2C590\n834\x2C745 -> 834\x2C949\n843\x2C401 -> 564\x2C122\n179\x2C212 -> 179\x2C32\n354\x2C906 -> 233\x2C906\n593\x2C439 -> 196\x2C42\n707\x2C446 -> 242\x2C446\n511\x2C84 -> 511\x2C406\n109\x2C299 -> 100\x2C290\n410\x2C79 -> 410\x2C784\n806\x2C923 -> 54\x2C171\n592\x2C83 -> 592\x2C189\n413\x2C28 -> 413\x2C469\n17\x2C844 -> 17\x2C691\n130\x2C419 -> 205\x2C344\n374\x2C247 -> 849\x2C247\n650\x2C344 -> 653\x2C344\n563\x2C942 -> 563\x2C726\n771\x2C966 -> 450\x2C966\n499\x2C693 -> 788\x2C693\n962\x2C458 -> 962\x2C356\n28\x2C683 -> 765\x2C683\n432\x2C546 -> 432\x2C708\n519\x2C974 -> 176\x2C974\n797\x2C744 -> 280\x2C227\n505\x2C228 -> 547\x2C228\n401\x2C366 -> 401\x2C754\n356\x2C470 -> 123\x2C470\n57\x2C909 -> 229\x2C909\n343\x2C880 -> 539\x2C880\n221\x2C851 -> 221\x2C297\n520\x2C677 -> 894\x2C677\n216\x2C805 -> 688\x2C805\n158\x2C901 -> 847\x2C901\n98\x2C129 -> 98\x2C969\n793\x2C203 -> 210\x2C786\n852\x2C855 -> 135\x2C138\n944\x2C90 -> 103\x2C931\n691\x2C768 -> 583\x2C768\n784\x2C617 -> 637\x2C764\n222\x2C160 -> 819\x2C757\n145\x2C982 -> 145\x2C216\n837\x2C355 -> 99\x2C355\n324\x2C121 -> 324\x2C14\n773\x2C851 -> 773\x2C413\n778\x2C550 -> 686\x2C458\n81\x2C56 -> 338\x2C313\n356\x2C512 -> 356\x2C441", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kMaxIndex, Type = Double, Dynamic = False, Default = \"1000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTestInput, Type = String, Dynamic = False, Default = \"0\x2C9 -> 5\x2C9\n8\x2C0 -> 0\x2C8\n9\x2C4 -> 3\x2C4\n2\x2C2 -> 2\x2C1\n7\x2C0 -> 7\x2C4\n6\x2C4 -> 2\x2C0\n0\x2C9 -> 2\x2C9\n3\x2C4 -> 1\x2C4\n0\x2C0 -> 8\x2C8\n5\x2C5 -> 8\x2C2", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
