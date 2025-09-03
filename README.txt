# Kanamachi: Blind Man's Buff (Bangladeshi Edition)

You can build, play, and SELL this with **Godot 4.x** without writing any code yourself.

## How to run
1. Install Godot 4.x (free) from godotengine.org.
2. Open Godot > `Import` > choose this folder `Kanamachi_BlindBuff_Godot4` > `Main.tscn` will be the main scene.
3. Press **Play**. Controls: **WASD/Arrow keys** to move. **Q** to **Ping** and briefly reveal runners.

## Goal
You are the **Seeker** (blindfolded). Use **sound beeps** that speed up when you get closer to a runner and your **Ping** ability to tag all three runners in each arena: **Village Field**, **School Yard**, and **Dhaka Rooftop**.

## How to export (sellable build)
- In Godot: **Project > Export**. Add presets for **Windows**, **Linux**, **macOS**, or **Web** (HTML5). For Android, install Android build tools (Godot docs show steps).
- Set an icon and name in **Project > Project Settings > Application**. Replace `assets/player.png` with your own for store branding.

## How to customize (no coding)
- Replace images in `assets/` with your own art (keep same filenames to avoid edits).
- To add characters: duplicate a `Runner` node in the **Runners** group in the scene and it will work automatically.
- To make it harder or easier: in **Player** node, adjust `speed` or `tag_radius` in the Inspector. In **Runner** nodes, adjust `speed`.

## Business/Store ideas
- Make a richer art pack (Bangla dresses, Eid decoration, Rickshaw patterns).
- Add story screens describing **Kanamachi** culture and rules.
- Price the desktop/Web version low or ad-supported on mobile.