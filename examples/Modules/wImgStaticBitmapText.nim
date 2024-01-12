import winim
import ../../ForkedwNim

var
  x: float
  y: float

type
  wImgStaticBitmapText* = ref object of wStaticBitmap
    mStaticText* : wStaticText

wClass(wImgStaticBitmapText of wStaticBitmap):
  proc init*(self: wImgStaticBitmapText, parent: wWindow, id = wDefaultID,
      label: string = "", bitmap: wBitmap = nil, pos = wDefaultPoint, size = wDefaultSize,
      style: wStyle = wAlignLeft) {.validate.} =

    wStaticBitmap(self).init(parent=parent, id=id, bitmap=bitmap, pos=pos, size=size, style=wSbAuto)

    self.mStaticText = StaticText(parent=parent, id=id, label=label, pos=pos, size=size, style=style)

    self.mStaticText.setBackgroundColor(-1)

    self.wEvent_Size do (event: wEvent):
      echo("wImgStaticBitmapText is Scaled")

      x = float(self.getPosition.x) + (self.getSize.width / 2) - (self.mStaticText.getSize.width/2)
      y = float(self.getPosition.y) + (self.getSize.height / 2) - (self.mStaticText.getSize.height/2)

      self.mStaticText.setPosition((int(x), int(y)))
      cover(self.mStaticText, self)
