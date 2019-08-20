---
layout: subpage
title: "Intro to TouchDesigner"
---

<img 
src="{{site.baseurl}}/assets/touchdesigner.png" 
style="max-width: 600px;" 
/>

> Download the [chop_dat_data.tox](https://drive.google.com/open?id=1F71l2Xh94vETsBxO1qEyLFkx1nxFazj7) and [intro_td.toe](https://drive.google.com/open?id=1tMGxQgNpjmRVDqkwoHmYm9SnjyOkx7BW) files from the [TouchDesigner Examples](https://drive.google.com/drive/folders/144ml7hfzFDR0Y7ZKa4WMo_aPQbVOkqTP?usp=sharing) folder on Google Drive.

## What is TouchDesigner?

TouchDesigner is a node-based programming platform used primarily for visual content generation and delivery. From the [Derivative Website](https://www.derivative.ca/):

> TouchDesigner is a visual development platform that equips you with the tools you need to create stunning realtime projects and rich user experiences. Whether you're creating interactive media systems, architectural projections, live music visuals, or simply rapid-prototyping your latest creative impulse, TouchDesigner is the platform that can do it all.

We're using TouchDesigner in this course because it offers the lowest barrier to entry for getting interactive projects up and running. It comes packaged with pre-built functionality to integrate with commercial lighting systems, create sound, and communicate Arduino microcontrollers.

## First Things to Know

Working with the TouchDesigner interface, getting started.

<iframe src="https://player.vimeo.com/video/160552892?color=fffffff&title=0&byline=0&portrait=0" width="600" height="338" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

<iframe src="https://player.vimeo.com/video/168540270?color=fffffff&title=0&byline=0&portrait=0" width="600" height="338" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## Operators

Projects in TouchDesigner are called "networks" and consist of several types of functional nodes called [operators](https://docs.derivative.ca/index.php?title=Operator).

COMPs - Components - Object components (3D objects), Panel components (2D UI gadgets), and miscellaneous components. Components contain other operators.
TOPs - Texture Operators - all 2D image operations.
CHOPs - Channel Operators - motion, audio, animation, control signals.
SOPs - Surface Operators - 3D points, polygons and other 3D "primitives".
DATs - Data Operators - ASCII text as plain text, scripts, XML, or organized in tables of cells.
MATs - Material Operators - materials and shaders.

Each operator has specific [parameters](https://docs.derivative.ca/Parameter) and [flags](https://docs.derivative.ca/Flag) that control different aspects of that operator's functionality.

Operators either create data (generators) or modify data (filters). In the `OP Create Dialog`, generators are highlighted in a darker color and filers are highlighted in a lighter color. We connect operators by drawing lines between the inputs and outputs of different operators. In this way, we are often able to see, in real time, how our data is being changed.

## Data

Data in Touchdesigner can be confusing. Raw data (tables, lists, collections) is usually handled by CHOPs and DATs.

### Data and CHOPs

CHOPs usually boil all forms of data into two dimensions: samples and channels. If you imagine a spreadsheet of data, you could potentially store that data in a CHOP in which each row of the spreadsheet is a _sample_ and each column is a _channel_ or VICE VERSA. This makes more sense when you think of a streaming signal. Take a look at the image below:

<img
src="{{site.baseurl}}/assets/td_data.png"
style="max-width: 600px;"
/>

You can see that we have a `noise` CHOP with its parameters and a `chopto` DAT and its parameters. The `noise` CHOP has three `channels`, each with different shaped signal-like lines. Looking at the parameters window above the CHOP, you'll see we are on the `channel` tab, we have three channels written out `chan1`, `chan2`, `chan3`. We have a start number of 0 and an end number of 1999. Next to the start and end sliders, you'll see a dropdown in which we've selected `I`, which stands for "samples". In this configuration, we have three `channels` and 2000 `samples`. This is our collection of data as stored in a CHOP.

Next to that CHOP is a `chopto` DAT, which takes data from a CHOP and populates an internal data container. In the parameters of that DAT, you'll see we've chosen the `output` to "column per channel". This means that each channel will have it's own column and each sample will occupy a new row.

## Connecting Operators

You can connect operators together by dragging a wire from the output of one operator (on the right hand side of the operator) to the input of another operator (on the left of each operator). Note, generators usually do not have inputs. This type of connection signifies data flow. In most cases, data is created in a generator and then passed into a series of filters to create the desired effect, motion, or data.

## References

TouchDesigner also allows you to use each operator's parameters, channels and data to drive parameters in other operators using _references_.

#### Channel References

<img 
src="{{site.baseurl}}/assets/td_chan_reference.png" 
style="max-width: 600px;" 
/>

In the image above, we are controlling the color of the `constant` TOP, with _references_ to the three channels in the `null` CHOP. The syntax for performing this kind of _channel reference_ is:

`op('NAME_OF_OPERATOR')['NAME_OF_CHANNEL']`

You can also use the _index_ of the channel you want instead of the name. Another technique for referencing a channel is to click on the "Active View" button on an operator (this is the star looking button on the bottom right of each operator), then clicking an dragging the channel onto the parameter that you want to modify.

#### Parameter References

<img 
src="{{site.baseurl}}/assets/td_par_reference.png" 
style="max-width: 600px;" 
/>

In the image above, we are controlling the effect and width of filter2 with _parameter references_ to filter1. The syntax for this is:

`op('NAME_OF_OPERATOR').par.NAME_OF_PARAMETER`

You can also reference parameters by clicking on the operator that you want to reference, clicking the `+` symbol next to the parameter that you want to reference, and then right-clicking the abbreviated parameter name. This will bring up a small menu in which you can choose to "copy parameter". Next, click on the parameter in the target operator and left click to bring up a menu. Select "paste references" and your parameter should be properfly referenced.

## Importing from Examples

TouchDesigner will only allow you to have one project open at a time, making copying and pasting from example projects difficult. Many tutorials will include `.tox` files, which can be dropped directly into your project from the desktop.

You can also share work with others by exporting a `.tox` file. To do this, create a new "Basic COMP" and copy/paste all of the relevant network into that COMP. Then you can right-click on the COMP and select "Save Compontent .tox".

## External Editor

Futher along in the course you may want to use DAT operators to create and run custom Python scripts or GLSL shaders. You can set up TouchDesigner to use an external text editor (something like VSCode or Atom). To do this, open the "Preferences" window from either the File menu or the TouchDesigner menu. Select the "DAT" tab and click on the folder icons next to Text Editor and Table Editor.

## Resources

Check out the [Resources]({{site.baseurl}}/resources/) page for links to TouchDesigner tutorials and example repositories.
