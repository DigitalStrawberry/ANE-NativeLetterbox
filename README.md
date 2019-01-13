# ANE-NativeLetterbox

A simple extension to display native letterbox layer on iOS, useful for limiting content size on devices with a "notch" like the iPhone X.

## Getting started

Download the ANE from the [releases](../../releases/) page and add it to your app's descriptor:

```xml
<extensions>
    <extensionID>com.digitalstrawberry.ane.letterbox</extensionID>
</extensions>
```

## API Overview

The extenstion is supported on iOS only. Use the `isSupported` getter to check for device support:

```as3
if(NativeLetterbox.instance.isSupported)
{
    ...
}
```

If the API is supported, use the `setHorizontalLetterbox` and/or `setVerticalLetterbox` method to create the letterbox. You can customize the letterbox's size (in pixels), color and alpha:

```as3
NativeLetterbox.instance.setHorizontalLetterbox(90, 0x000000, 1);
NativeLetterbox.instance.setVerticalLetterbox(30, 0xFF0000, 1);
```

The letterbox can be brought to front if it ends up covered by other native views:

```as3
NativeLetterbox.instance.bringToFront();
```

### Changelog

#### January 13, 2019 (v1.0.0)

* Public release