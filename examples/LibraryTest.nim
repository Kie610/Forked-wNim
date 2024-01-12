import
  resource/resource

import ../ForkedwNim
# import wNim/[autolayout, wApp, wFrame, wIcon, wPanel, wMenu, wMenuBar, wSplitter,
#   wStatusBar, wTextCtrl, wStaticText, wFont]


import Modules/public_variables
import Modules/config_file_load
import Modules/wImgStaticBitmapText

import Modules/Images_Process

var
  main_app: wApp
  main_frame: wFrame

  conPanel: wPanel
  
  conLabel1: wImgStaticBitmapText
  conButton11: wImageButton
  conButton12: wImageButton

  conLabel2: wTextCtrl
  conButton21: wImageButton
  conButton22: wImageButton

  font: wFont
  conFontDialog: wFontDialog

  conStaticBitmap: wStaticBitmap


main_app = App(wSystemDpiAware)
main_frame = Frame(title="TEST", size=(1920, 1080))

conPanel = Panel(main_frame, style=(wDoubleBuffered + wTransparentWindow))

conLabel1 = ImgStaticBitmapText(conPanel, label="Label 1", bitmap=Bitmap(imgTitle), style=(wAlignCenter + wAlignMiddle))
conButton11 = ImageButton(conPanel, label="BUTTON 11", mybutton=buOne, normalimg=imgButton, hoverimg=imgDocument, selectedimg=imgTitle)
conButton12 = ImageButton(conPanel, label="BUTTON 12", mybutton=buThree, normalimg=imgButton, hoverimg=imgDocument, selectedimg=imgTitle)

conLabel2 = TextCtrl(conPanel, value="Label 2", style=(wTeReadOnly + wTeMultiLine + wTeRich))
conButton21 = ImageButton(conPanel, label="BUTTON 21", mybutton=buTwo, normalimg=imgButton, hoverimg=imgDocument, selectedimg=imgTitle)
conButton22 = ImageButton(conPanel, label="BUTTON 22", mybutton=buTwo, normalimg=imgButton, hoverimg=imgDocument, selectedimg=imgTitle)

conFontDialog = FontDialog(conPanel, font)

conStaticBitmap = StaticBitmap(conPanel, bitmap=Bitmap(imgBackground), style=(wSbAuto))

conLabel1.setBackgroundColor(-1)
conLabel2.setBackgroundColor(-1)

const layout_string = """
        HV:|[conPanel]|
        HV:|~[conStaticBitmap]~|

        H:|~[Area(80%)]~|
        V:|[Area]|

        H:[Area:-[Left(Right)]-[Right]-]

        V:[Left:-(15%)-[conLabel1]-[conButton11(20%)]-[conButton12(20%)]-(15%)-]
        V:[Right:-(15%)-[conLabel2]-[conButton21(20%)]-[conButton22(20%)]-(15%)-]"""


proc main()
proc layout()
proc event()

#################################################
#   メインモジュール
#################################################
when isMainModule:
  try:
    echo("Test Start")
    ConfigLoading()
    
    main_frame.setSize((app_config.WindowSizeX, app_config.WindowSizeY))
    layout()

    event()
    main()

  finally:
    echo("Test Finish")
    ConfigSaving()

proc main() =
  echo("Main Proc")  

  echo("show")
  main_frame.center()
  main_frame.show()
  main_app.mainLoop()

proc event() =
  main_frame.wEvent_Size do ():
    echo("Size Event")
    echo("Now Size: " & $getSize(main_frame).width & " x " & $getSize(main_frame).height)

    layout()
  
  conStaticBitmap.wEvent_CommandLeftClick do ():
    echo("Bitmap Clicked")

  conButton11.wEvent_Button do ():
    conButton11.imgSet()
    main_frame.setSize((app_config.WindowSizeX, app_config.WindowSizeY))
    layout()

  conButton12.wEvent_Button do ():
    conbutton12.imgSet()
    echo("wGetMousePosition : " & $wGetMousePosition())
    echo("wGetScreenSizeX : " & $wGetScreenSize().width)
    echo("wGetScreenSizeY : " & $wGetScreenSize().height)
    echo("wSysScreenX : " & $wGetSystemMetric(wSysScreenX))
    echo("wSysBorderX : " & $wGetSystemMetric(wSysBorderX))
    echo("wGetWinVersion : " & $wGetWinVersion())
    echo("main_frame border" & $wFrame.wResizeBorder)
    
    wUtils.wSetMousePosition((100, 100))

  conButton21.wEvent_Button do ():
    conButton21.imgSet()
    
    var result: wId = conFontDialog.showModal

    if result == wIdOk:
      echo("Accepted")
      
      font = conFontDialog.getChosenFont()
      echo("mPointSize: " & $font.mPointSize)
      echo("mFamily: " & $font.mFamily)
      echo("mWeight: " & $font.mWeight)
      echo("mItalic: " & $font.mItalic)
      echo("mUnderline: " & $font.mUnderline)
      echo("mStrikeout: " & $font.mStrikeout)
      echo("mFaceName: " & $font.mFaceName)
      echo("mEncoding: " & $font.mEncoding)

    else:
      echo("Canceled")

  conButton22.wEvent_Button do ():
    # echo("Button 22 Pushed")
    conButton22.imgSet()

proc layout() =
  echo("autolayout")

  main_frame.autolayout(layout_string)
  # conB22StaticBitmap.autolayout("HV:|[conButton22]|")
