set projectName to "Fundamentals of Computing"
set tagName to "Mac"
set taskName to "Review latest FoC module page changes"

tell application "OmniFocus"
	tell the default document
		set theProject to the first flattened project whose name is projectName
		set theTag to the first flattened tag whose name is tagName
		tell theProject
			set theTask to make new task with properties {name:taskName, primary tag:theTag, flagged:true}
			tell the note of theTask
				make new file attachment with properties {file name:theFile, embedded:false}
			end tell
		end tell
	end tell
end tell
