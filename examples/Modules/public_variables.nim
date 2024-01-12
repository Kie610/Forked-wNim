import ../../ForkedwNim

type
  ButtonSelect* {.byref.} = enum
    buOne ,buTwo, buThree ,buFour, buDefault

type
  wImageButton* = ref object of wButton
    mImgSelected: wBitmap
    mImgHover: wBitmap
    mImgNormal: wBitmap
    mMyButton: ButtonSelect

var buttonState*: ButtonSelect = buDefault

proc toNormalImg*(self: wImageButton) =
  if self.mImgNormal != nil:
    echo("Button " & $self.mMyButton & " to Normal Image")
    self.setBitmap(self.mImgNormal)
    self.setBitmapPosition(wCenter)

proc imgSet*(self: wImageButton, image: wBitmap = nil) =
  if (image == nil) and (self.mImgSelected != nil):
    echo("Button " & $self.mMyButton & " Select")
    self.setBitmap(self.mImgSelected)
    self.setBitmapPosition(wCenter)

    buttonState = self.mMyButton

    var
      parent = self.getParent()
    
    for child in parent.getchildren():
      if (child.mClassName == "Button") and (child != self):
        wImageButton(child).toNormalImg()
  
  elif image != nil:
    if self.mMyButton != buttonState:
      self.setBitmap(image)
      self.setBitmapPosition(wCenter)

wClass(wImageButton of wButton):
  proc init*(self: wImageButton, parent: wWindow, id = wDefaultID, label: string = "",
      mybutton: ButtonSelect, normalimg: wImage, hoverimg: wImage = nil, selectedimg: wImage = nil,
      pos = wDefaultPoint, size = wDefaultSize, style: wStyle = 0) {.validate.} =

    ## Initializes a button.
    wButton(self).init(parent=parent, id=id, label=label, pos=pos, size=size, style=style)

    self.mMyButton = mybutton

    if normalimg != nil:
      self.mImgNormal = Bitmap(normalimg)
      self.imgSet(self.mImgNormal)
      self.wEvent_MouseLeave do ():
        echo("Button " & $mybutton & " Leave")
        if buttonState != mybutton:
          self.imgSet(self.mImgNormal)


    if hoverimg != nil:
      self.mImgHover = Bitmap(hoverimg)
      self.wEvent_MouseEnter do ():
        echo("Button " & $mybutton & " Enter")
        if buttonState != mybutton:
          self.imgSet(self.mImgHover)


    if selectedimg != nil:
      self.mImgSelected = Bitmap(selectedimg)