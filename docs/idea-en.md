# Idea

2D Top-Down Simple Shooter

## Game's Goal

> Last at a level for a set amount of time and defeat all enemies.

## What should it be?

### Objects

- Player
  - Movement
  - Rotation of Shooting Direction
  - Shooting
  - Removal after Health Depletion
- Bullet
  - Movement in One Direction
  - Removal Off-Screen after a Set Time
  - Dealing Damage to Enemies followed by Self-Removal
- Enemy
  - Movement Towards the Player
  - Dealing Damage to the Player upon Contact
  - Removal after Health Depletion

### Gameplay

- Manager: a node within the game level that locates the player, enemy spawn points and a timer to manage gameplay flow. Not a parent node. Only searches for enemies when they need to be removed after the game is completed.
  - Learns of time expiration from the timer and ends the game
  - Removes all enemies on the level after the game ends
  - Disables enemy spawn points after the game ends
- Timer: A node within the game level that decreases the gameplay time. The Manager subscribes to the game end notification.
  - Notifies the Manager of game end after time expires
- Enemy Spawn Points: a node within the game level that generates a specified number of enemies at set intervals.
  - Spawns enemies at set intervals
  - Spawns a specified number of enemies
  - Ability to disable enemy spawning logic
- Timer Interface
  - Locates the timer
  - Displays the remaining timer time

## Realization

[Godot Engine 4.3-stable](realization-en.md)
