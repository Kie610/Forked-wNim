#====================================================================
#
#               wNim - Nim's Windows GUI Framework
#                 (c) Copyright 2017-2019 Ward
#
#====================================================================

## This event is generated by wHyperLinkCtrl.
#
## :Superclass:
##   `wCommandEvent <wCommandEvent.html>`_
#
## :Events:
##   ==============================  =============================================================
##   wHyperLinkEvent                 Description
##   ==============================  =============================================================
##   wEvent_HyperLink                The hyperlink was clicked.
##   ==============================  =============================================================

# forward declaration
proc getVisited*(self: wHyperLinkCtrl, index = -1): bool {.inline.}

DefineIncrement(wEvent_HyperLinkFirst):
  wEvent_HyperLink

proc isHyperLinkEvent(msg: UINT): bool {.inline.} =
  msg == wEvent_HyperLink

method getIndex*(self: wHyperLinkEvent): int {.property, inline.} =
  ## Returns the index of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = pnmLink.item.iLink

method getUrl*(self: wHyperLinkEvent): string {.property, inline.} =
  ## Returns the URL of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = nullTerminated($pnmLink.item.szUrl)

method getLinkId*(self: wHyperLinkEvent): string {.property, inline.} =
  ## Returns the link ID of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = nullTerminated($pnmLink.item.szID)

method getVisited*(self: wHyperLinkEvent): bool {.property, inline.} =
  ## Returns the visited state of the hyperlink.
  # visted state returned from PNMLINK always false?
  result = wHyperLinkCtrl(self.mWindow).getVisited(self.getIndex())
