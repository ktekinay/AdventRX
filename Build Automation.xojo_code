#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyPuzzleDataLinux
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vUHV6emxlJTIwRGF0YS8=
				End
			End
			Begin BuildStepList Mac OS X
				Begin IDEScriptBuildStep ChangeOptimizationLevelMac , AppliesTo = 0, Architecture = 0, Target = 0
					Sub MaybeChangeOptimization(toValue As String)
					const kKey as string = "App.OptimizationLevel"
					
					var currentOptimizationLevel as string = PropertyValue(kKey)
					
					if currentOptimizationLevel <> toValue then
					PropertyValue(kKey) = toValue
					end if
					End Sub
					
					
					if DebugBuild then
					MaybeChangeOptimization "0"
					else
					MaybeChangeOptimization "4"
					end if
					
				End
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyPuzzleData
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 1
					Subdirectory = 
					FolderItem = Li4vUHV6emxlJTIwRGF0YS8=
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
