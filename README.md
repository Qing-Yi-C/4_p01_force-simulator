# Project 01 For NeXT CS
### Class Period: 4
### Name0: Qing Yi Chen
### Name1: Zariya Kardar
---


Your mission is to create a Processing program that demonstrates different physical forces, building off of the framework we have been creating in class. Your program should do the following:
- Reasonably model gravity (in the classical mechanics sense) and the spring force. The force calculations for both have already been done in class.
- Reasonably model two other physical forces.
- Produce different simulations that demonstrate each force individually.
- Produce a simulation that combines at least 3 of the forces.
- Use a data structure to hold multile `Orb` (or `Orb` subclasses), to aid in at least 3 of your simulations.

This project will be completed in phases. The first phase will be to work on this document. Use makrdown formatting. For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

All projects will require the following:
- Researching new forces to impliment.
- Methods for each new force the returns a `PVector` similar to how `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
  - Each simulation should have a way to toggle movement on or off, similar to the programs we've been writing.
  - Look back at the gravity classwork assignment. Note how each simulation had its own setup in order to demonstrate a spcific physical interaction. You want to recreate that type of experience.
  - A visual menu at the top providing information about which simulation is currently active and if movement is on or off.
  - The user shoudl be able to switch between simluations using the numebr keys as follows:
    - `1`: Gravity
    - `2`: Spring Force
    - `3`: Friction Force
    - `4`: Electric Force
    - `5`: Combination

## Phase 0: Force Selection, Analysis & Plan

#### Custom Force 0: Friction

### Forumla 0
What is the formula for your force? Including descirptions/definitions for the symbols. You may include a picure of the formula if it is not easily typed.

F = μN 
where F is the force of friction, µ (mu) is the coefficient of friction, and N is the normal force

### Force 0
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - applyForce(), getDensity(), size, mass, color, position, velocity, acceleration

- Does this force require any new constants, if so what are they and what values will you try initially?
  - It needs a constant for the coffiecient of friction, which will be represented as the float MU.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - no because normal force will be calculated as a float and mu is a constant. The vector direction of the friction force returned will be in the x axis, so normal force doesn't need to be a Pvector if we can just copy the velocity vector, normalize, then multiply by the opposing/negative float friction magnitude

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - It's applied based on the environment or the surface where the orb will roll
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - Yes; we need to calculate the normal force which is mass of orb * gravity

#### Custom Force 1: Electric Force

### Forumla 0
What is the formula for your force? Including descirptions/definitions for the symbols. You may include a picure of the formula if it is not easily typed.

Fe = (K * q1 * q2) / (r^2)
K = Coulumbs constant = 9 * 10^9
q1 = charge of point charge 1
q2 = charge of point charge 2
r = radial distance between each point charge

### Force 1
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - all the instance variables, applyForce, getDensity

- Does this force require any new constants, if so what are they and what values will you try initially?
  - Coulumbs constant of 9 * 10^9

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - we need to update the parameter list of the Orb constructor to include charge which will be a float data type. the other non-electric demos will use orbs of neutral charges (0 charge) so this new parameter doesn't break the entire program

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - the magnitude of electric force will be the same between two orbs, so two orbs will either attract (opposite charges) or repel (same charges) each other
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - we need to calculate and constrain the radius

### Simulation 1: Gravity
Describe what your gravity simulation will look like. Explain how it will be setup, and how it should behave while running.

An array of orbs will spawn at the top of the screen, then fall down at the same velocity, then bounce off the bottom & fall back down after reaching its peak. The gravitational force will eventually decrease the height of each orb's bounce and end in all the orbs sitting at the bottom of the screen.

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

An array of orbs will be connected to each other with springs (colored lines based on compression/extension), and an inital force will applied to them to make the spring system stretch and shrink.

### Simulation 3: Force 0 (Friction)
Describe what your Force 0 simulation will look like. Explain how it will be setup, and how it should behave while running.

An orb will spawn on a smooth, frictionless flat surface that has a green frictional surface in the center. The orb will be given an initial push force to get it to move to the right and eventually cross the rough surface. As the ball moves across the rough surface, its movement will visibly slow down because of the opposing frictional force. Eventually when the ball bounces off the right side and rolls back across the rough surface a second time, its movement will completely stop.

### Simulation 4: Force 1 (Electric)
Describe what your Force 1 simulation will look like. Explain how it will be setup, and how it should behave while running.

Two point charges of random charges will spawn on the screen with their charges displayed (either positive or negative). These two point charges will then intereact with each other by either attracting or repelling each other because of their charges.

### Simulation 5: Combination
Describe what your combined force simulation will look like. Explain how it will be setup, and how it should behave while running.

There will be an array of point charges (orbs with a charge) that will be connected with springs and interact with each other based on their charges. As these orbs attract, repel, stretch, and shrink, they will also have a gravitional force applied to them so they all somewhat fall downward.
