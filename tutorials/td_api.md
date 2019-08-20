---
layout: subpage
title: "TouchDesigner + API"
---

<img 
src="{{site.baseurl}}/assets/td_json_overview.png" 
style="max-width: 600px;" 
/>

> Download the [td_json.toe](https://drive.google.com/open?id=1JUppYt8u2PfoV0aBJSAcqX_8Z2AVDPug) file from the [TouchDesigner Examples](https://drive.google.com/drive/folders/144ml7hfzFDR0Y7ZKa4WMo_aPQbVOkqTP?usp=sharing) folder on Google Drive.


## What is an API?

<img 
src="https://blog.restcase.com/content/images/2016/11/api-collaboration.png" 
style="max-width: 600px;" 
/>


`Application Programming Interface`. In it's most basic form, an API is a way for different programs or different parts of a program to share information or functionality.

In terms of the WEB, people often use the term to talk about how one application or website can get data from another. 

We can often access another website's data through a formatted URL. Each website is has a different way to correctly format a URL to access its information. The rules for formatting a `request` is spelled out in that API's documentation.

For example, the sample `endpoint` that we'll be using for this tutorial is `http://67.205.143.120/campusEnergy?building=porter`. In this case, the request URI consists of the IP address of the website, description of the data we are trying to fetch, and a dynamic `query` that allows us to choose what information we are requesting.

```
{
    "building":"porter",
    "kWh":10,
    "kWhPercentAvg":125,
    "gph":1100,
    "gphPercentAvg":178
}
```

The above response is formatted in `JSON`. JSON has become the standard format for API responses. The basic idea of JSON is that each entry is defined by a `key` and `value`. In this case, "building" is the key and "porter" is the values can be in the form of string, integer or float.

## TouchDesigner + APIs
TD's `web` DAT allows us to send `GET` requests to any website and store the response in a text DAT. 


<img 
src="{{site.baseurl}}/assets/td_json_web.png" 
style="max-width: 600px;" 
/>

You can change the URI that you want to retrieve in the parameters window of the `web` DAT. Clicking the `Fetch` button sends the request and retreives the response. 

<img 
src="{{site.baseurl}}/assets/td_json_pythong.png" 
style="max-width: 600px;" 
/>

TouchDesigner doesn't have any built-in JSON parsing, so we'll need to write some custom python go get the JSON data into a format that TouchDesigner can use.

You'll need to select the python DAT and type `ctrl + r` to get the python script to run.