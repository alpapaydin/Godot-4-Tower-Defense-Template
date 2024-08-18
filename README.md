# Tower Defense Game Template in Godot

Welcome to the Tower Defense Game Template for Godot! This project is designed to jumpstart the development of tower defense games by providing a fully functional base, including demo turrets, maps, and enemies. It also offers an easy-to-extend system, allowing you to add new turrets, maps, and enemies with minimal effort.

## Features

- **4 Demo Turrets**: A variety of turrets with different stats, abilities, and upgrade paths:
  - **Gatling Gun**: Fast-firing turret with moderate damage.
  - **Flamethrower**: High-speed turret with piercing capabilities.
  - **Ray Turret**: Slow but powerful turret with a long-reaching ray attack.
  - **Explosive Turret**: Deals heavy damage with a slow attack speed.

- **2 Demo Maps**: Two different environments to challenge your strategic skills:
  - **Grass Map**: A lush, green battlefield with balanced difficulty.
  - **Desert Map**: A harsher environment with increased starting resources.

- **Drag and Drop Turret Deployment**: Easily place turrets on the map by dragging and dropping them from the HUD.

- **Turret Upgrading and Selling**: Upgrade turrets to improve their stats or sell them to recover some of the cost.

- **Easy Customization**: 
  - **Turrets**: Define new turrets with custom stats, upgrades, and visuals by editing the `Data` autoload script.
  - **Enemies**: Add new enemies with unique health, speed, and difficulty.
  - **Maps**: Create new maps with customizable enemy routes and obstacles.

- **Simple HUD and Main Menu**: A straightforward user interface that includes a main menu and an in-game HUD for managing your turrets and viewing game stats.

## How to Use

1. **Clone the Repository**: 
   - Clone this project to your local machine using Git.

2. **Open in Godot**: 
   - Open the project in Godot Engine.

3. **Run the Game**: 
   - Run the main scene to start the demo and experience the default setup.

4. **Customizing the Game**:
   - **Adding New Turrets**: Add your turret definitions under the `turrets` dictionary in the `Data` script. You can duplicate turret scene and customize that if you want, be sure to edit scene path in turret data.
   - **Adding New Enemies**: Similarly, add your enemies under the `enemies` dictionary.
   - **Adding New Maps**: Define new maps by adding them under the `maps` dictionary, and ensure to link the appropriate scene and assets. Duplicate any of the maps and add your background, then make sure to edit enemy path in PathFollow2D and turret obstacles in CollisionPolygon2D.

## Structure

- **Assets**: Contains all the sprites and textures for turrets, bullets, enemies, and maps.
- **Scenes**: Holds the scenes for turrets, maps, and other game components, along with the scripts.

## Contributing

Contributions are welcome! If you have ideas for new turrets, maps, or other features, feel free to fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
