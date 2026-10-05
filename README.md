#Description

The basic-rpg-game program hosted on this repository was created as a learning exercise to test my knowledge
and learning of Godot 4.0's GDScript programming language.

##Features
- An overworld map that the player can navigate. (Not yet implimented)
	- From this screen the player can open the player menu or enter into a battle screen upon starting a combat.
	- The overworld map will change if the player reaches certain locations. If they step onto the tile
	for a town/city, the map will transition and then display the map for the town. It will change back once
	they enter the tile for the town's exit.
	- Enemies will spawn occasionally and wander the map, touching them will start a battle.
		- These enemies will be limited to a set amount so that the map doesn't fill up with them.
- A battle screen that appears when the player encounters an enemy. (In progress)
	- The screen shows the player characters images and the enemy characters images, (In-Progress)
	- Has a menu that shows the different combat action categories the player can take, with
	sub-menus that appear to display the actions the player can take in the chosen category. (In-Progress)
	- Another menu displays information about the currently selected unit. (In-Progress)
- A menu screen that allows the player to access different pages. (Not yet implimented)
	- An inventory/Stats page under the player menu
	- A skills page, showing the player's known skills
	- A quests page, that lists the quests the player is currently undertaking. 
	- An options page, that allows the player to change settings for the game.
- Player character information is stored in a separate file as well as enemy character information.
both of which are loaded into the battle scene when the battle begins.
	
##Installation

- 
