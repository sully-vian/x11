open Ctypes

module Types (F : Ctypes.TYPE) = struct
  open F

  let magic_lor = Obj.magic ( lor )

  module EventMask = struct
    type t = int const

    let ( lor ) = magic_lor
    let noEventMask = constant "NoEventMask" int
    let keyPressMask = constant "KeyPressMask" int
    let keyReleaseMask = constant "KeyReleaseMask" int
    let buttonPressMask = constant "ButtonPressMask" int
    let buttonReleaseMask = constant "ButtonReleaseMask" int
    let enterWindowMask = constant "EnterWindowMask" int
    let leaveWindowMask = constant "LeaveWindowMask" int
    let pointerMotionMask = constant "PointerMotionMask" int
    let pointerMotionHintMask = constant "PointerMotionHintMask" int
    let button1MotionMask = constant "Button1MotionMask" int
    let button2MotionMask = constant "Button2MotionMask" int
    let button3MotionMask = constant "Button3MotionMask" int
    let button4MotionMask = constant "Button4MotionMask" int
    let button5MotionMask = constant "Button5MotionMask" int
    let buttonMotionMask = constant "ButtonMotionMask" int
    let keymapStateMask = constant "KeymapStateMask" int
    let exposureMask = constant "ExposureMask" int
    let visibilityChangeMask = constant "VisibilityChangeMask" int
    let structureNotifyMask = constant "StructureNotifyMask" int
    let resizeRedirectMask = constant "ResizeRedirectMask" int
    let substructureNotifyMask = constant "SubstructureNotifyMask" int
    let substructureRedirectMask = constant "SubstructureRedirectMask" int
    let focusChangeMask = constant "FocusChangeMask" int
    let propertyChangeMask = constant "PropertyChangeMask" int
    let colormapChangeMask = constant "ColormapChangeMask" int
    let ownerGrabButtonMask = constant "OwnerGrabButtonMask" int
  end

  module KeyMask = struct
    type t = int const

    let ( lor ) = magic_lor
    let shiftMask = constant "ShiftMask" int
    let lockMask = constant "LockMask" int
    let controlMask = constant "ControlMask" int
    let mod1Mask = constant "Mod1Mask" int
    let mod2Mask = constant "Mod2Mask" int
    let mod3Mask = constant "Mod3Mask" int
    let mod4Mask = constant "Mod4Mask" int
    let mod5Mask = constant "Mod5Mask" int
  end

  module GrabMode = struct
    type t = int const

    let grabModeSync = constant "GrabModeSync" int
    let grabModeAsync = constant "GrabModeAsync" int
  end
end
