---
layout: subpage
title: "TouchDesigner, Pixelmapping + DMX"
---


> Download the [td_pixelmapper.toe](https://drive.google.com/open?id=1Wnb-IWbTXGHitYjDsAZwrrNh6s8-pMrW) file from the [TouchDesigner Examples](https://drive.google.com/drive/folders/144ml7hfzFDR0Y7ZKa4WMo_aPQbVOkqTP?usp=sharing) folder on Google Drive. 

> Download the [pixelMapper.tox](https://drive.google.com/open?id=1KJCrY-0_17tAk82lKiwXTHT0AgbnvB5c) component from the [TouchDesigner Examples](https://drive.google.com/drive/folders/144ml7hfzFDR0Y7ZKa4WMo_aPQbVOkqTP?usp=sharing) folder on Google Drive.

> Download and install the Advatek Assistant Software for [macOS](https://itunes.apple.com/us/app/advatek-assistant/id990140692?ls=1&mt=12) or [Windows](https://www.advateklights.com/download/928/)

<img 
src="{{site.baseurl}}/assets/td_pixlite_diagram.png" 
style="max-width: 600px;" 
/>

## What is DMX?

DMX is a protocol standard for communicating with and controlling "addressable" lights. This is the standard communication protocol for theatrical lighting, stage lighting and most architectural lighting. 

> From Wikipedia: DMX512 (Digital Multiplex) is a standard for digital communication networks that are commonly used to control stage lighting and effects. It was originally intended as a standardized method for controlling light dimmers, which, prior to DMX512, had employed various incompatible proprietary protocols. It soon became the primary method for linking controllers (such as a lighting console) to dimmers and special effects devices such as fog machines and intelligent lights. DMX has also expanded to uses in non-theatrical interior and architectural lighting, at scales ranging from strings of Christmas lights to electronic billboards. DMX can now be used to control almost anything, reflecting its popularity in theaters and venues.


<img 
src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/SimpleDmxUniverse.gif/1200px-SimpleDmxUniverse.gif" 
style="max-width: 600px;" 
/>


#### Some Facts:

- DMX can control up to 512 `channels`. 
- Each channel has 256 steps of resolution (0-255). 
- Each group of 512 channels is called a `universe`
- DMX is a "bus" protocol, which means that with every frame, a DMX `controller` communicates all of its channel information. 
- Each `slave device` is has a `start address`, and only listens to the parts of the DMX packet that pertain to its address.
- Standard DMX is traditionally transmitted with 3-pin or 5-pin XLR-style cables and connectors.

<img 
src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/XLR5_pinouts.svg/600px-XLR5_pinouts.svg.png" 
style="max-width: 200px;" 
/>


### What is sACN E1.31?
DMX can be sent over a network as well. There are two ways of doing this. [Art-Net](https://en.wikipedia.org/wiki/Art-Net) is the older and less robust protocol. [E1.31 Streaming ACN (sACN)](https://opendmx.net/index.php/E1.31) is newer, easier to use and more robust. We will be using sACN to communicate between TouchDesigner and our PixLite controllers.


## What are Addressable LEDs
It is important to know that most "addressable LEDs" do NOT use the DMX protocol. Most "addressable LEDs" require some piece of hardware to sit between them and a DMX controller. In our case, we will be sending DMX over sACN to our PixLite controllers. The PixLite controllers will then translate our DMX signal into another protocol that the LEDs can understand.

### LED Addressing
The LED strands that we are using are addressed sequentially, starting from the "pixel" that is nearest to the PixLite controller. 



## Pixel Mapping in TouchDesigner
The goal of this tutorial is to understand one method for transferring video content (live, prerecorded, generated) to physical LED "pixels" in physical space. We want to "map" the video content to the pixels, retaining the motion of the video by sampling the video at points relative to the spacing and arrangement of the physical layout of the pixels. To do this, we will follow these steps:

1. Export polyline geometry in the OBJ format. Each point of the polyline corresponds to an LED pixel location.
2. Import OBJ to TouchDesigner and use the locations of the vertices to sample video.
3. Transform color sampling data to DMX data
4. Send DMX over a network to a PixLite controller
5. Set up a PixLite controller to listen to DMX and communicate with our addressable LEDs.

This tutorial will not cover step 1. For best results:
1. always export your polyline with positive coordinates. 
2. Before exporting, place your geometry as close to the origin (0,0) as possible.
3. Work in the XY plane. 
4. I like to make (but not export) a bounding box of my polyline geometry to better understand the dimensions of my geometry (total width and height of geometry).

Steps 3 and 4 are taken care of in the [pixelMapper.tox](https://drive.google.com/open?id=1KJCrY-0_17tAk82lKiwXTHT0AgbnvB5c).


## Using the pixelMapper TOX Component

<img 
src="{{site.baseurl}}/assets/td_pixmapp_comp.png" 
style="max-width: 600px;" 
/>

This custom component has two inputs:
- SOP input for linking your imported OBJ pixel locations
- TOP input for linking your source texture/video content

And one output
- TOP output that allows you to preview or simulate what the lights will look like after mapping.

To start, create a `filein` SOP and, in the Parameters pane, click the `+` button to choose the correct OBJ file from your computer. Link this SOP to the SOP input on the pixelMapper COMP.

Next, create a simple TOP (i like to use my webcam to test) and connect that to the TOP input of the pixelMapper COMP. 

Finally, create a `null` TOP and connect it to the output of the pixelMapper COMP. 

Lets look the Parameters of the pixelMapper COMP:

<img 
src="{{site.baseurl}}/assets/td_pixmap_params.png" 
style="max-width: 600px;" 
/>

`active` - this turns the active sending of DMX on and off
`universe` - this is the DMX universe that we want to use (more on this later)
`width` - total width of input geometry
`height` - total height of input geometry
`camZoom`, `camTransX`, `camTransY` - move the preview camera around to see everything. these do not affect the LED mappings.

The most important parameters here are `width` and `height`. For these, enter the total height and total width of geometry that you've imported.


## Setting up the PixLite Controller
If you want to get a deeper understanding of the PixLite Controller, have a look at the [manual](https://www.advateklights.com/resources/download-info/pixlite-4-rev-1-2-manual/).

### Physical Setup

#### Parts
1. Variable voltage power supply
2. PixLite controller
3. Ethernet cable
4. LED strand
5. Two small screwdrivers
6. male/male jumper cables


<img 
src="{{site.baseurl}}/assets/td_pixlite_LED_diagram.png" 
style="max-width: 600px;" 
/>

**Connections**
1. Set the power supply to 5 volts
2. Connect the power supply to the PixLite 
3. Use jumpers to connect the female end of the LED strand to `OP1` of the PixLite
  - Red = +
  - Blue = GND
  - Whie = Dat
4. Connect the PixLite to your computer via an Ethernet cable


#### Network Setup

**macOS** 
1. Open your network preferences.
2. Make sure your ethernet is connected
3. Turn off wifi
4. Select the appropriate network adaptor (will say something about ethernet)
5. Set "configure IPv4" to "manually"
6. Set your IP address to 192.168.0.10
7. Set your subnet mask to 255.255.255.0

<img 
src="{{site.baseurl}}/assets/network_setup.png" 
style="max-width: 600px;" 
/>


**Windows**
1. Open your network preferences
2. Set you IP address to 192.168.0.10
3. Set your subnetmask to 255.255.255.0
4. Turn off wifi

<img 
src="{{site.baseurl}}/assets/network_setup_windows.png" 
style="max-width: 600px;" 
/>

#### PixLite Setup
You should have already downloaded and installed the Advatek Assistant Software for [macOS](https://itunes.apple.com/us/app/advatek-assistant/id990140692?ls=1&mt=12) or [Windows](https://www.advateklights.com/download/928/).

<img 
src="{{site.baseurl}}/assets/advatek_search.png" 
style="max-width: 600px;" 
/>

1. Open the "Advatek Assistant" software.
2. Change the "Select Adapter" to 192.168.0.10
3. Click the "Search" button (make sure the green "power" light on the PixLite is solid)
4. You should see the PixLite 4 unit become visible. Double click it.
5. Go to the "LEDs" tab in the popup and change the "Pixel IC" to "WS2811"

<img 
src="{{site.baseurl}}/assets/advatek_LED_select.png" 
style="max-width: 600px;" 
/>

6. Go to the "control" tab and make sure the Universe is `1`, Start Channel is `1` and Pixels Per Output is `50`
7. Click the "OK" button. This will restart the PixLite unit.

<img 
src="{{site.baseurl}}/assets/advatek_universe.png" 
style="max-width: 600px;" 
/>

8. Allow the PixLite to fully reboot. (green light will stop blinking).
9. Research for the unit and select it.
10. Go to the "test" tab, change the "Set Test" menu to "Set Color" and click "Set"
11. Move the color picker around and you should see all of the LEDs change accordingly.


#### TouchDesigner Again
After communication with the PixLite unit is established and confirmed through the Advatek Assistant, go back to TouchDesigner and set the "Active" parameter of the pixelMapper to "ON"