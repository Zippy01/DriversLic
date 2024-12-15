# Imperial DriversLic Script

The **DriversLic** script enhances the *Imperial CAD* system by enabling users to display and share their driver's license information directly within the game. This script works in tandem with the *CivilianInt* script, utilizing the active civilian profile set by *CivilianInt* for seamless in-game interactions.

---

## Features

- **Show ID** - Displays the driver's license information for the active civilian profile set by *CivilianInt*.
- **Share ID with Nearby Players** - Allows players to share their ID information with the nearest player for quick identification.

## Commands

| Command               | Description                                                                                     |
|-----------------------|-------------------------------------------------------------------------------------------------|
| `/id`                 | Displays your ID from the active civilian profile set by the *CivilianInt* script.             |
| `/giveid`            | Shows your ID from the active civilian profile to the nearest player within a 10-meter radius.  |

---

## Installation

To install the **DriversLic** script, follow these steps:

1. **Download the Script Files**  
   Download the latest release from this repository.

2. **Add to Your Server Resources**  
   Place the `DriversLic` folder into your server's resources directory.

3. **Community Configuration**  
   The script requires a `community ID` and `API Secret Key` from *Imperial CAD*. If not already set, follow these instructions:
   - Locate your community ID in *Admin Panel > Customization > Community ID*.
   - Add the following lines to your `server.cfg` file:
     ```plaintext
     setr imperial_community_id "COMMUNITY_ID_HERE"
     setr imperialAPI "API_Secret_Key_HERE"
     ```
   - If your server already uses other *Imperial* scripts with this same configuration, you can skip this step.

4. **Restart Your Server**  
   Restart your server to apply the changes.

---

## Requirements

- **Imperial CAD**: Ensure you have a valid *Imperial CAD* subscription and that it's configured, as this script interacts directly with CAD.
- **CivilianInt Script**: The *CivilianInt* script must be installed and active, as it sets the civilian profile required by *DriversLic*.

## Usage Notes

The **DriversLic** script relies on the active civilian profile selected by the *CivilianInt* script. To use the `/id` or `/giveid` commands, ensure that an active civilian profile has been set with *CivilianInt*.

---

### License

This script is owned by *Imperial Solutions*. Unauthorized copying, distribution, or use of this script without permission is prohibited and may result in legal actions.

---

For further assistance, visit the *Imperial Solutions* [Support Discord](https://discord.gg/N5UJBSDdsn) or refer to our support channels.
