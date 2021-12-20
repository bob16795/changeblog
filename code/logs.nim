import tables
import strutils
import strformat
import os

proc readLog*(filename: string): seq[tuple[name: string,
    posts: Table[string, seq[string]]]] =
  result = @[]
  var name = "latest"
  var id = 0
  var posts: Table[string, seq[string]]
  for line in readFile(filename).split('\n'):
    var linedata = line.split("|")
    if line == "": continue
    if linedata.len == 2:
      if not posts.contains(linedata[0]):
        posts[linedata[0]] = @[]
      posts[linedata[0]] &= linedata[1]
    elif posts.len != 0:
      result &= (name: name, posts: posts)
      posts.clear()
      name = line
      if line[0] == '\\':
        name = line[1..^1]
    else:
      name = line
      if line[0] == '\\':
        name = line[1..^1]
  result &= (name: name, posts: posts)

proc createPost*(username: string, message, heading: string) =
  var filename = "data/logs/" & username & ".cgl"
  var contents = readFile(filename)
  contents = &"{heading}|{message}\n{contents}"
  writeFile(filename, contents)

proc versionCount*(filename: string): int =
  if not fileExists(filename): return 0
  result = 0
  for line in readFile(filename).split('\n'):
    var linedata = line.split("|")
    if line == "": continue
    if linedata.len != 2:
      result += 1
