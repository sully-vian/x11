module Types (_ : Ctypes.TYPE) : sig
  module EventMask : sig
    type t

    val ( lor ) : t -> t -> t
    val noEventMask : t
    val keyPressMask : t
    val keyReleaseMask : t
    val buttonPressMask : t
    val buttonReleaseMask : t
    val enterWindowMask : t
    val leaveWindowMask : t
    val pointerMotionMask : t
    val pointerMotionHintMask : t
    val button1MotionMask : t
    val button2MotionMask : t
    val button3MotionMask : t
    val button4MotionMask : t
    val button5MotionMask : t
    val buttonMotionMask : t
    val keymapStateMask : t
    val exposureMask : t
    val visibilityChangeMask : t
    val structureNotifyMask : t
    val resizeRedirectMask : t
    val substructureNotifyMask : t
    val substructureRedirectMask : t
    val focusChangeMask : t
    val propertyChangeMask : t
    val colormapChangeMask : t
    val ownerGrabButtonMask : t
  end

  module KeyMask : sig
    type t

    val ( lor ) : t -> t -> t
    val shiftMask : t
    val lockMask : t
    val controlMask : t
    val mod1Mask : t
    val mod2Mask : t
    val mod3Mask : t
    val mod4Mask : t
    val mod5Mask : t
  end

  module GrabMode : sig
    type t

    val grabModeAsync : t
    val grabModeSync : t
  end
end
