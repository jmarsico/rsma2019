---
layout: subpage-detailed
title: "Creative Assignment 1: Home Hack"
---

#### Due: Tuesday February 6, 6:30pm before class. No late work.

#### Submit to: [DioT 2018: Home Hack](http://ideate.xsead.cmu.edu/gallery/pools/creative-project-1-home-hack)

Note: There is a [discovery](#planning-your-project-ie-discovery) attached to this project. This is due on __Thursday Jan 25, 2018 6:30pm; directly before class.__

---

# Introduction

A huge element of the Internet of Things vision is the idea that anyone can easily personalize product experiences and interactions to their needs. By making connections between internet appliance, the appliance can adapt to individual needs, preferences and desires. Through these customised connections, there’s the potential to create incredible value to the IoT end user.  We’re quite a way off from this, but the potential for hyper-personalized, super-customized ‘internet appliances’ to make meaningful differences in daily habits, simplify routines, and enhance our livingspaces can already be seen in the DIY community.

Development platforms like [Particle](https://www.particle.io/) are empowering maker, hacker and hobbyist enthusiasts. Using these platforms they can quickly create solutions to problems in their lives: to remotely turn on their sprinklers, to hack their coffee pot to brew at the right time in the morning, or get their dishwashers or washing machines text them when the cycle is finished, or track the number of times their fridge is opened each day.

And this is the idea behind your first project:  **Make a quick hack for your home using the Particle platform.**

Here’s the twist: __the solution should be personalised, but not to you.__ Choose someone else in your home - a housemate, a partner, or a family member - and design a personalized IoT prototype for them.  (There’s some examples below.)

## Learning Objectives

As part of this assignment you’ll be asked to:

* Explore opportunities for connection and personalisation that the IoT and prototyping platforms like Particle bring.

* Develop your working knowledge of sensors, input and output components

* Work individually to explore, design, develop and program circuits and electronics with the Particle platform;

* Embrace tinkering and hacking and develop a prototype connected solution;

## Overview

Using the tutorials and guides provided you are going to create a simple home hack of your own design that:

1. Employs at least three components, and at least one is a sensor;

2. Shares sensor information on the internet through the Cloud API and/or allows it to be controlled via the internet

3. Provides simple status feedback locally; and

4. Offers more detailed information online or through third party services

The [tutorials and guides](http://diotlabs.daraghbyrne.me) are an excellent starting point for this project. Most of what you need to create this project is already given to you; you just need to recombine and tweak it to make it work. Part 1 of this project, a discovery exercise, will help you assemble these resources and plan your project too.

This creative assignment is to be completed **individually**.

## Context (before you begin)

Before you start this project you’ll need to figure out what kind of IoT solution are you trying to create. To do this, you’ll need to find a simple problem that you want to solve. You don’t need to do anything radically innovative, just solve a simple everyday problem by making data available through sensors.

The focus here is on technical implementation rather than aesthetics or presentation. Make sure you have smart use of components and well implemented code that lands at some well thought out functionality.

To help you get started, here’s some things you could try out as potential hacks:

* **Monitoring plants:** Have they green fingers or maybe they kill every house plant they touch? Temperature and light could tell you if you have optimal conditions for your plant’s growth. It’s also really easy to build a [moisture sensor with just two nails](http://www.instructables.com/id/Garduino-Gardening-Arduino/step4/Build-Your-Moisture-Sensor/)!

* **Indoor Air Quality**: Do they need motiviation to vacuum or let some fresh air in. There’s loads of sensors for monitoring air quality, dust and gases.

* **Breathalizer:** Like air quality you can also find alcohol and other chemical detectors. It’s super easy to [make your own breathalyzer](http://www.instructables.com/id/Arduino-Breathalyzer/).

* **Home Security:** Do they feel unsafe at home alone? There’s lots of options for home security. Use a [Hall Effect Sensor](http://www.adafruit.com/products/158?gclid=CK3Y8PSLo8MCFU4V7AodrUkAGA) and a magnet to detect doors opening and closing. Use an [PIR sensor ](http://www.adafruit.com/products/189)or  an [ultrasonic range finder](http://www.adafruit.com/products/164) to look people/objects/movement nearby the sensor (and get their distance). Use the tilt sensor in your kits to detect if a lock is turned.

* **Connected Cooking:** Are the a coffee connoisseur? Could you let them know if their coffee cooled to the right temperature to drink? Are they forgetful - could you give them a nudge if they leave a fridge or cupboard door open (tilt sensor/Hall effect)?

* **Connected Pets:** Could you to monitor your pets when you're away? Make sure your dog's not barking? Feed your fish remotely? Or set up an internet connected cat toy to occupy your feline friend while you're not home?

**General thoughts:** What is it they do everyday or should do everyday? Is there something you could build to make an activity faster, better or automated? Is there something you could do to change their behavior in a positive way (and that they want!)?

## Planning your project (i.e. [discovery]({{site.baseurl}}/deliverables/discoveries))

Due: __Thursday, 25th 2018; directly before class.__

The first phase of your project is planning. This is a quick assignment designed to help you gather the resources and assets you'll need to complete it.

There's three things you'll deliver for this

1. _Proposal_: Provide a short 100-word proposal for your project. Create a project in the gallery and add this proposal by the deadline. Describe what your hack is and how it will work.

2. _Precedents_: _Research and report on __two technical precedents___ that immediately help you in your project. e.g. discover a similar project contributed by a community member to [Hackster](https://particle.hackster.io/) or the [Particle Forums](https://community.particle.io/), find a [code snippet](http://playground.arduino.cc/Main/GeneralCodeLibrary), uncover a useful [library](https://docs.particle.io/guide/tools-and-features/dev/#using-community-libraries) for your components, etc. Basically find a starting point that you can borrow, extend or employ in your project.  *Create a Post* in the [#precedent]({{ site.slack }}/messages/discoveries/) channel on slack that includes the label "#homehack" for grading purposes e.g. An open source nest #homehack. For more details, see [discoveries]({{site.baseurl}}/deliverables/discoveries).

3. _Parts_: Plan the parts your going to use in the project. Make a list of the components (sensors, actuators, inputs, etc.) you'll use in your circuit and add them to yoru documentation. Make sure you have them or can access them in the lab i.e. they're available. Post this to your project on the Gallery too.

_Note_ It's perfectly OK to hack, remix and rework online examples in this course. In fact, it's encouraged. But you MUST acknowledge it in your documentation and you must build on them i.e. your work should have unique elements and show effort beyond these resources (see Using Online Material below).

## Project Requirements

At a minimum you must complete the Core requirements for this project. The project builds a series of progressively more advanced features. Students with prior experience with microcontrollers are strongly encouraged to complete all parts.

All students should be able to complete at minimum the Basic

#### Core Requirement: Connected Hack

* You must identify a scenario

* Your hack must contain a **minimum of three components**: Choose any combination of input (button, switch, pot), output (light, sound, motion) and sensing (temperature, pressure, noise, etc.). **At least one sensor must be used.**

* You must create a circuit using those inputs, outputs and sensors

* You must read from those sensors and make that data available on the Particle cloud.

#### Basic: Status Indicator

It’s often helpful to know if a sensor platform is working. Next, you should add an LED to blink when data is updated.

For the Basic requirement, you will add a simple indication of status to the sensor platform.  A simple single color LED will suffice. Blink for 100ms when sensor data has been collected and uploaded. Then wait for at least 1 second before retrieving data again.

#### Intermediate: Sensor Feedback

The data is online and we know it’s being uploaded, but wouldn’t it be nice if we can see what’s happening at a glance?

Use an LED (or other output) to create a glanceable interface for the sensor data. Map the current reading to light and create a visual way to see changes in the data over time. You can take a few approaches to this:

* Use a individual single-color LED and fade it to correspond with a sensor value

* Use a row of single-color LED to create a simple bar graph

* Use an RGB LED to create a color representation e.g. red is bad, green is good, etc.

#### Advanced: Visual Alerts

We can see what the data is now, but do we know when we need to take action? Should our hack tell us when we can ignore it and when we need to do something?

First, decide what the user should know: What changes in data do you want to reveal and why? At what times do you need to take action? For example if we have a plant monitor and the soil is too dry, then the glanceable should blink or indicate action is needed.

Next, implement some decisions (using logic [if] statements) to make the visual display to get the user to take action.

#### Expert: Making the Data Useful

Great. We have something that gives us a lot of information when we’re nearby, but what about when we’re not?

**Option 1: Log the Data**

* Run the sensor for a day and collect the data from it (write a program to collect the data periodically from the device.)

* Make use of the data by graphing it or visualizing it in some way.

* Report your findings and anything you found interesting about the sensor data.

**Option 2: Connect the Cloud information by either:**

* Creating a web-page or mobile app which displays the **live data** and/or graphs it so that someone can view it when they’re away from the device

* Delivering a remote alert (by email, twitter, push notification, etc.) to the user at the same time as the visual alert is triggered, so that they are notified to take action even when they mightn't be nearby. _Hint:_ IFTTT integrations for Particle are really useful here.

## Outcome and Process Documentation

* **Problem Statement:** Introduce who you are designing for, how they could benefit from an IoT appliance and why you chose this person and the problem

* **Goal:** What kind of solution are you trying to create and why? How does it address the problem? etc.

* **Process:** Show a record of your work as it progressed. This should include: components used, photos and videos of the circuits assembled, code (and versions of your code), reflections and challenges encountered, how you solved problems, iterated etc. Be able to tell the story of your work.

* **Outcome:** Be able to illustrate the final outcome. Explain how complete the prototype is and what you would do/add next? Your documentation for this section must include:

	* Completed code
	* A circuit diagram (use [Fritzing](http://fritzing.org/home/) or similar)
	* A bill of parts
	* A video of your completed project (use in context, operation, etc.)

	You are welcome to include illustrative diagrams (workflow, etc.), additional photos, or a concept video.

* **Reflection:** Reflect on the process of making this project. What did you learn? What would you do differently?  Did you get where you wanted to? If not, why not? What do you need to get there, etc?

Each section should be **_200 words max._** and well illustrated (images, videos, etc.)

For the Project’s summary description: it must be tweetable - summarise your outcome in no more than 140 characters

## Using Online Material:

It is perfectly fine to use examples, code, tutorials, and things you find on the web to help you realize your project. That’s part of the open-source mentality that surrounds much of Making, Arduino and microcontrollers. However, you cannot just copy and paste these solutions. In your documentation **_you must acknowledge where you got this content from_**. Include a link to any tutorials, guides, or code that are part of your final solution.

## Final Documentation:

You should upload your work to the IDeATe Gallery. You can sign up at the following link: [{{site.gallery}}/users/sign_up]({{site.gallery}}users/sign_up)

Projects should be added to the pool linked above.

To add your project to the pool,

1. first sign up and be logged in

2. Click the ‘Join’ button on the top right

3. You are a member of the pool

4.  You will now see an option to: ‘Add a new project to this pool’. Click this to begin adding your project information.

You should provide **_a clear and concise_** description of your project, your process, and the outcomes. It should be quick to get an overview of the project.  Ideally, your description of the outcomes should be repeatable too i.e. anyone in the class can replicate it easily from the information provided.
