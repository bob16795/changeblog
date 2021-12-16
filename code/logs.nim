import tables
import strutils
import strformat

proc readLog*(filename: string): string =
  var tmpVersion = "latest"
  var headings: Table[string, seq[string]]
  for line in readFile(filename).split('\n'):
    var linedata = line.split("|")
    if line == "": continue
    if linedata.len == 2:
      if not headings.contains(linedata[0]):
        headings[linedata[0]] = @[]
      headings[linedata[0]] &= linedata[1]
    elif headings.len != 0:
      result &= "<div class=\"entry\">\n"
      result &= "<h2>" & tmpVersion & "</h2>\n\n"
      for h, d in headings:
        if headings[h] != @[]:
          result &= "### " & h & "\n"
          for data in headings[h]:
            result &= "\n- " & data
          result &= "\n\n"
      headings.clear()
      tmpVersion = line
      if line[0] == '\\':
        tmpVersion = line[1..^1]
      result &= "</div>\n"
    else:
      tmpVersion = line
      if line[0] == '\\':
        tmpVersion = line[1..^1]
  result &= "<div class=\"entry\">\n"
  result &= "<h2>" & tmpVersion & "</h2>\n\n"
  for h, d in headings:
    if headings[h] != @[]:
      result &= "### " & h & "\n"
      for data in headings[h]:
        result &= "\n- " & data
      result &= "\n\n"
  result &= "</div>"

proc createPost*(username: string, message, heading: string) =
  var filename = "data/logs/" & username & ".cgl"
  var contents = readFile(filename)
  contents = &"{heading}|{message}\n{contents}"
  writeFile(filename, contents)

proc versionCount*(filename: string): int =
  result = 0
  for line in readFile(filename).split('\n'):
    var linedata = line.split("|")
    if line == "": continue
    if linedata.len != 2:
      result += 1
