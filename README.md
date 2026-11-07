# Roblox Server Information Overlay Script

Sols Server Scout is a Roblox script that creates a client-side server information overlay for Sol's RNG-style experiences. The Roblox script displays a configured private-server link and checks supported game data locations to show the current biome. It is an information overlay only and does not automate rolling, bypass game systems, or interact with protected remotes.

## Install

1. Open Roblox Studio and open your place.
2. In Explorer, open `StarterPlayer > StarterPlayerScripts`.
3. Insert a `LocalScript`.
4. Copy the complete contents of `ServerInfoOverlay.client.lua` into the `LocalScript`.
5. Near the top of the script, replace `PASTE_YOUR_PRIVATE_SERVER_LINK_HERE` with your private-server URL.
6. Start the place with **Play** to view the overlay.

## Use

1. Run the place after installing the script.
2. View the overlay in the upper-right corner of the screen.
3. The overlay displays the configured private-server link.
4. The biome value refreshes every two seconds.
5. Close the overlay with the `X` button in its upper-right corner.
6. If the biome cannot be found, the overlay displays `Unknown (game data not exposed)`.

The script checks these supported biome locations:

- `Workspace.Biome` as a `StringValue` or `ObjectValue`
- `Workspace.CurrentBiome` as a `StringValue` or `ObjectValue`
- `ReplicatedStorage.Biome` as a `StringValue` or `ObjectValue`
- `ReplicatedStorage.CurrentBiome` as a `StringValue` or `ObjectValue`
- `Workspace` attributes named `Biome` or `CurrentBiome` containing a string

Roblox does not provide a normal client-side API that reveals the current server's private-server share URL. The displayed link must therefore be configured manually. For a game you own, expose biome information through one of the supported locations.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/f06b3dbe-b30f-43a6-977e-e3d2d1b22119?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=f06b3dbe-b30f-43a6-977e-e3d2d1b22119
