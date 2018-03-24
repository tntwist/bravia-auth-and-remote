## Setup

You need to set your TV to use a pre-shared key.

1. Navigate to: [Settings] → [Network] → [Home Network Setup] → [IP Control]
2. Set [Authentication] to [Normal and Pre-Shared Key]
3. There should be a new menu entry [Pre-Shared Key]. Set it to as you want.

## Usage

1. Run `print_ircc_codes.sh TV_IP_HERE` to get an overview of the commands possible.
2. Run `send_command.sh TV_IP_HERE ONE_COMMAND_IRCC_CODE_HERE PRE_SHARED_KEY_HERE`. A command looks like `AAAAAQAAAAEAAABgAw==`. You can run `send_namedcommand.sh TV_IP_HERE ONE_NAMED_COMMAND_HERE PRE_SHARED_KEY_HERE` for a more readable code in your automations. A named command looks like `TvPower` or `Num1`.
3. The TV will execute the command and immediately return. If you want to navigate through menus, you'll have to manually `sleep` until the TV has finished the command/animation.

See `example_goto_media_player.sh` on how to build your automations.

Have fun!

### More detailed explanation

The original blog post describes how to figure this out in general:
https://blog.yrden.de/2014/11/14/remote-control-bravia-tvs-with-authentication.html

StefanPuntNL figured out how to use it with a Pre-Shared-Key, which is much simpler:
https://www.domoticz.com/forum/viewtopic.php?t=8301
