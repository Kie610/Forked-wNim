#====================================================================
#
#               wNim - Nim's Windows GUI Framework
#                (c) Copyright 2017-2021 Ward
#
#====================================================================

import resource/resource
import wNim/[wApp, wImageList, wImage, wBitmap, wIcon, wFrame, wStatusBar, wRebar,
  wToolBar, wButton, wComboBox, wUtils]

type
  MenuID = enum
    idTool1 = wIdUser, idTool2, idTool3, idTool4

const resource1 = staticRead(r"images/1.png")
const resource2 = staticRead(r"images/2.png")
const resource3 = staticRead(r"images/3.png")
const resource4 = staticRead(r"images/4.png")
const resource5 = staticRead(r"images/cancel.ico")

let imageList = ImageList(24, 24)
imageList.add(Image(resource1).scale(24, 24))
imageList.add(Image(resource2).scale(24, 24))
imageList.add(Image(resource3).scale(24, 24))
imageList.add(Image(resource4).scale(24, 24))
imageList.add(Image(resource5).scale(24, 24))

let img1 = Image(resource1).scale(16, 16)
let img2 = Image(resource2).scale(16, 16)
let img3 = Image(resource3).scale(16, 16)
let img4 = Image(resource4).scale(16, 16)

wSetSysemDpiAware()
let app = App()
let frame = Frame(title="Rebar Example")
frame.icon = Icon("", 0) # load icon from exe file.

let statusbar = StatusBar(frame)
let reset = Button(frame, label="Reset Layout And Freeze")
let rebar = Rebar(frame)
rebar.setImageList(imageList)

let toolbar = ToolBar(rebar)
toolbar.addTool(idTool1, "Tool 1", Bitmap(img1), "Tool1", "This is tool 1.")
toolbar.addTool(idTool2, "Tool 2", Bitmap(img2), "Tool2", "This is tool 2.")
toolbar.addTool(idTool3, "Tool 3", Bitmap(img3), "Tool3", "This is tool 3.")
toolbar.addTool(idTool4, "Tool 4", Bitmap(img4), "Tool4", "This is tool 4.")

let button = Button(rebar, label="Exit")

let combobox = ComboBox(rebar, value="Combobox Item1",
  choices=["Combobox Item1", "Combobox Item2", "Combobox Item3"],
  style=wCB_READONLY)

let bandToolBar = rebar.addBand(toolBar)
let bandEmpty = rebar.addBand()
let bandButton = rebar.addBand(button, 4)
let bandCombobox = rebar.addBand(combobox, 2, "Combo", style=wRbBreak)
rebar.maximizeBand(bandEmpty)

frame.wEvent_Tool do (event: wEvent):
  statusbar.setStatusText($MenuID(event.id) & " clicked.")

combobox.wEvent_ComboBox do (event: wEvent):
  statusbar.setStatusText(combobox.getValue())

button.wEvent_Button do ():
  frame.close()

let layout = rebar.layout
var freeze = true

reset.wEvent_Button do ():
  if freeze:
    reset.label = "Unfreeze"
  else:
    reset.label = "Reset Layout And Freeze"

  rebar.disableMinMax(freeze)
  rebar.disableDrag(freeze)
  rebar.layout = layout
  freeze = not freeze

frame.center()
frame.show()
app.mainLoop()
