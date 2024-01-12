import ../../ForkedwNim

var
  icoIcon*: wIcon
  imgBackground*: wImage
  imgButton*: wImage
  imgDocument*: wImage
  imgTitle*: wImage
  imgBackgroundAspect*: float

icoIcon = Icon(readFile(r"images/wNim.ico"))
imgBackground = Image(readFile(r"images/background.png"))
imgButton = Image(readFile(r"images/Button.png"))
imgDocument = Image(readFile(r"images/Document.png"))
imgTitle = Image(readFile(r"images/Title.png"))