# Project 01 For NeXT CS
### Class Period: 4
### Name0: Qing Yi Chen
### Name1: Zariya Kardar
---

### New Forces Implemented
Name & Describe the two new forces you created.

1. Force of Friction:
This force is defined by the equation F = µN, and is the force between two surfaces that are sliding against each other. Friction is the force that slows moving objects to a stop. The rougher the texture of the surface that the object is moving on, the more friction there will be, and the faster the object will slow to a stop. Friction is also the force that resists you when you try to pull or push heavier objects, such as a large box.

2. Electric Force:
This force is based on Coulomb's Law, which defines the electrostatic force between two point charges. Coulomb's Law is represented by the equation F = (k\*q1\*q2)/r^2. This force can be one of either attraction or replusion, depending on the signs of the charges of the objects. If they have opposite signs, the point charges will attract each other. If they have the same sign, they will repel each other.

---

### Simulation Explanations
Explain what each of your simulations do, and what should appear when running them.

1. Gravity:
In the gravity simulation, an array of orbs is initialized at the top of the screen. Once moving (spacebar) is true, the force of gravity will be applied to every orb. These orbs should fall to the ground with an increasing velocity and then bounce back up to a height that is less than their starting point, then fall back down again. The force of gravity should not only make the orbs fall down, but also slowly pull them towards the bottom-center of the screen, where the Earth and its "core" would be.

2. Spring:
In the spring simulation, a fixed orb is initialized near the top of the screen. By using the keys '=' and '-', you can add or delete more orbs to the screen that will be attached to the fixed orb by a spring. The springs will initially attach to the fixed orb, however this can be changed by pressing the 's' key, which will connect the orbs to the orb right before them in the array, creating more of a chain of spring orbs. Once moving is true, the spring force will be applied to all orbs, making the springs stretch and compress as the orbs are pulled away from and towards the orb or fixed orb that they are connected to. In addition, while the spring is compressed, the line will turn red. The up, down, left, right arrow keys can also be used to change the location of the spring orbs (manually stretching/compressing the springs).

3. Friction:
In the friction simulation, an orb is initialized on a platform near the bottom of the screen. There is a section of the platform that will be green rather than red, and is the site where friction will be applied to the orb. Once moving is true, the orb will move across the platform towards the green section. Once it reachs the green section, the force of friction will slow the orb down until it eventually stops (velocity = 0).

4. Electric:
In the electric simulation, two point charges will be initialized at random coordinates on the screen. They will each bear a sign, "+" or "-", that shows the sign of their charge (the charges will also be displayed in the top right corner). Once moving is true, the point charges will either move towards or away from each other, depending on their signs. If they are opposite signs, they will attract each other, and the electrostatic force will become greater (faster) as they grow closer. Once they touch, the point charges will bounce off/swerve around each other, and then attract each other again. If the point charges have the same sign, they will repel each other. The electrostatic force will become smaller (slower) as they move away from each other, and it may appear as though they are not moving at all.

5. Combo
The combination simulation combines the forces of gravity, spring, and electrostatic. A series of orbs will be initialized at the top of the screen, just like the gravity simulation. However, they will also be connected by springs, similar to the spring force. Once moving is true, the orbs will fall due to gravity, but they will also be pulled in and pushed away to other orbs by the springs that connect them. The electric simulation should be turned on at the same time as the combination simulation, so that it will display the signs of the charges of the orbs. There is an electrostatic force being applied to the orbs, however it is less visible due to the magnitude of the gravity and spring forces.

---

### Changes
What changed about your program after the design phase? Were any of these changes the result of the demo day?

Our original forces were going to be friction and centripetal force, but after we realized centripetal force was not an individual force (it's when force is inward, but this can be manifested through various other forces such as gravitational force, frictional force, etc.), we changed our second force to be electric force instead. After the design phase, we decided to implement more into our spring simulation, hence the 's' key that changes the way the springs are connected, as well as the implementation of the built-in ArrayList object type, rather than creating a whole class, to be able to add/delete spring orbs. We also added the arrow keys to be allow us to manually stretch and compress the springs. We fixed our friction simulation, because we noticed that the orb's velocity was still not equal to 0 after traveling over the green friction section. This change was thanks to an observation from the demo day sheet! We organized our reset() method in a better way, by creating two more methods, falsify() and frame(), to take care of the booleans and the setup resets separately. In the electrostatic simulation, we made the orbs have different sizes based on the magnitude of their charges (larger absolute value = bigger orb). Finally, our combination simulation had not been finished for the demo day, so we focused on creating and debugging it.
