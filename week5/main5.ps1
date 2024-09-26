. (Join-Path $PSScriptRoot WebScraping.ps1)

$FullTable = gatherClasses
$NewTable = daysTranslator $FullTable

# List all the classes of Instructor Furkan Paligu
#$FullTable | Select-Object "Class Code", Title, Instructor, Location, Days, "Time Start", "Time End" | `
#                where{ $_."Instructor" -ilike "Furkan*" }

# List all the classes of Joyce 310 on mondays, only display class code and time
# sort by start time
#$FullTable | where-object{ ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | `
#                Sort-Object -Property "Time Start" | `
#                select "Time Start", "Time End", "Class Code"

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique
$ITSInstructors = $FullTable | Where-Object { `
                                $_."Class Code" -ilike "SYS*" -or
                                $_."Class Code" -ilike "NET*" -or
                                $_."Class Code" -ilike "SEC*" -or
                                $_."Class Code" -ilike "FOR*" -or
                                $_."Class Code" -ilike "CSI*" -or
                                $_."Class Code" -ilike "DAT*"
                            } |
                Sort-Object "Instructor" |
                select "Instructor" -Unique 
$ITSInstructors

# Group all the instructors by the number of classes they are teaching
$FullTable | Where-Object {$_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object -Property "Instructor" `
           | Select-Object Count,Name `
           | Sort-Object Count -Descending