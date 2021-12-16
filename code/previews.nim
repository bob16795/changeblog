import pixie
import types
import logs
import strutils

proc newFont(typeface: Typeface, size: float32, color: Color): Font =
  result = newFont(typeface)
  result.size = size
  result.paint.color = color

proc getError*(c: TData, un: string, size: string = "400x200"): string =
  var
    width = 800
    height = 200

  if size.split('x').len == 2:
    width = size.split('x')[0].parseInt()
    height = size.split('x')[1].parseInt()

  let image = newImage(width, height)
  let ctx = newContext(image)
  ctx.fillStyle = rgba(68, 68, 68, 255)
  ctx.fillRect(rect(vec2(0, 0), vec2(width.float, height.float)))

  ctx.fillStyle = rgba(34, 34, 34, 255)
  ctx.fillRect(rect(vec2(1, 20), vec2(width.float - 2, height.float - 21)))

  let typeface = readTypeface("/home/prestosilver/doc/rep/github.com/changeblog/fonts/Roboto-Regular.ttf")

  let spans = @[
      newSpan(un & "\n", newFont(typeface, 36, color(1, 1, 1, 1))),
      newSpan("\nreleases: " & $versionCount("data/logs/" & un & ".cgl") & "\n",
          newFont(typeface, 13, color(1, 1, 1, 1))),
      newSpan("\nchanges: " & $versionCount("data/logs/" & un & ".cgl") & "\n",
          newFont(typeface, 13, color(1, 1, 1, 1)))
  ]

  image.fillText(typeset(spans, vec2(380, 160)), translate(vec2(10, 30)))
  return image.encodeImage(ffPng)

proc getPreview*(c: TData, un: string, size: string = "400x200"): string =
  var
    width = 800
    height = 200

  if size.split('x').len == 2:
    width = size.split('x')[0].parseInt()
    height = size.split('x')[1].parseInt()

  let image = newImage(width, height)
  let ctx = newContext(image)
  ctx.fillStyle = rgba(68, 68, 68, 255)
  ctx.fillRect(rect(vec2(0, 0), vec2(width.float, height.float)))

  ctx.fillStyle = rgba(34, 34, 34, 255)
  ctx.fillRect(rect(vec2(1, 20), vec2(width.float - 2, height.float - 21)))

  let typeface = readTypeface("/home/prestosilver/doc/rep/github.com/changeblog/fonts/Roboto-Regular.ttf")

  let spans = @[
      newSpan(un & "\n", newFont(typeface, 36, color(1, 1, 1, 1))),
      newSpan("\nreleases: " & $versionCount("data/logs/" & un & ".cgl") & "\n",
          newFont(typeface, 13, color(1, 1, 1, 1))),
      newSpan("\nchanges: " & $versionCount("data/logs/" & un & ".cgl") & "\n",
          newFont(typeface, 13, color(1, 1, 1, 1)))
  ]

  image.fillText(typeset(spans, vec2(380, 160)), translate(vec2(10, 30)))
  return image.encodeImage(ffPng)
